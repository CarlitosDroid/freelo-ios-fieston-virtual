import Combine
import SocketIO
import XCTest
@testable import FiestonVirtual

final class SocketIOViewModelTests: XCTestCase {
    private var manager: SocketManager!
    private var socket: RecordingSocket!
    private var viewModel: SocketIOViewModel!
    private var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        manager = SocketManager(socketURL: URL(string: "http://127.0.0.1:8000")!)
        socket = RecordingSocket(manager: manager, nsp: "/")
        manager.nsps["/"] = socket
        viewModel = SocketIOViewModel(
            usersRepository: ChatUsersRepositoryStub(),
            socketManager: manager
        )
    }

    override func tearDown() {
        viewModel.stopListeners()
        subscriptions.removeAll()
        viewModel = nil
        socket = nil
        manager = nil
        super.tearDown()
    }

    func testStartingTwiceRegistersOnlyOneMessageListener() {
        var messages: [ChatMessage] = []
        observeMessages { messages.append($0) }
        viewModel.startListeners()
        viewModel.startListeners()
        socket.handleClientEvent(.connect, data: [])

        receiveMessage(id: "101", userID: 2)

        XCTAssertEqual(socket.connectCount, 1)
        XCTAssertEqual(messages.map(\.idMessage), ["101"])
    }

    func testReopeningRemovesOldMessageAndErrorListeners() {
        var messages: [ChatMessage] = []
        var errorCount = 0
        observeMessages { messages.append($0) }
        viewModel.$socketIOResult.sink { result in
            if case .ConnectionError = result { errorCount += 1 }
        }.store(in: &subscriptions)

        viewModel.startListeners()
        viewModel.stopListeners()
        socket.handleClientEvent(.error, data: ["ignored after stop"])
        XCTAssertEqual(errorCount, 0)
        receiveMessage(id: "ignored", userID: 2)
        XCTAssertTrue(messages.isEmpty)

        viewModel.startListeners()
        socket.handleClientEvent(.connect, data: [])
        receiveMessage(id: "102", userID: 2)
        socket.handleClientEvent(.error, data: ["test error"])

        XCTAssertEqual(messages.map(\.idMessage), ["102"])
        XCTAssertEqual(errorCount, 1)
    }

    func testJoinIncludesUserIdentityAndRunsAgainAfterReconnect() throws {
        viewModel.startListeners()
        socket.handleClientEvent(.connect, data: [])
        socket.handleClientEvent(.disconnect, data: [])
        socket.handleClientEvent(.connect, data: [])

        let joins = socket.emissions.filter { $0.event == JOIN_EVENT }
        XCTAssertEqual(joins.count, 2)
        let payload = try XCTUnwrap(joins.first?.items.first as? [String: Any])
        XCTAssertEqual(payload["idEvent"] as? Int, 3)
        XCTAssertEqual(payload["idUser"] as? Int, 1)
        XCTAssertEqual(payload["userName"] as? String, "Test User")
        XCTAssertEqual(payload["userImage"] as? String, "avatar.png")
    }

    func testOwnMessageAppearsOnlyWhenServerEchoArrivesAndIsOutgoing() throws {
        var messages: [ChatMessage] = []
        observeMessages { messages.append($0) }
        viewModel.startListeners()
        socket.handleClientEvent(.connect, data: [])

        viewModel.sendMessage(message: "Hola")
        XCTAssertTrue(messages.isEmpty)
        XCTAssertEqual(socket.emissions.last?.event, MESSAGE_EVENT)
        receiveMessage(id: "103", userID: 1)

        XCTAssertEqual(messages.count, 1)
        let message = try XCTUnwrap(messages.first)
        XCTAssertEqual(message.idMessage, "103")
        guard case .OUTGOING = message.viewType else {
            return XCTFail("The server echo of our message must be outgoing")
        }
    }

    func testIdenticalTextWithDifferentIDsRemainsTwoIncomingMessages() {
        var messages: [ChatMessage] = []
        observeMessages { messages.append($0) }
        viewModel.startListeners()
        socket.handleClientEvent(.connect, data: [])

        receiveMessage(id: "104", userID: 2)
        receiveMessage(id: "105", userID: 2)

        XCTAssertEqual(messages.map(\.idMessage), ["104", "105"])
        XCTAssertEqual(messages.map(\.messageText), ["Hola", "Hola"])
        for message in messages {
            guard case .INCOMING = message.viewType else {
                return XCTFail("Messages from another user must be incoming")
            }
        }
    }

    func testMalformedMessageReportsErrorWithoutAddingMessage() {
        viewModel.startListeners()
        socket.handleClientEvent(.connect, data: [])
        socket.handleEvent(MESSAGE_EVENT, data: [], isInternalMessage: true)

        guard case .ConnectionError = viewModel.socketIOResult else {
            return XCTFail("Missing message payload must report an error")
        }
    }

    private func observeMessages(_ receive: @escaping (ChatMessage) -> Void) {
        viewModel.$socketIOResult.sink { result in
            if case .ReceiveIncomingMessageSuccess(let message) = result {
                receive(message)
            }
        }.store(in: &subscriptions)
    }

    private func receiveMessage(id: String, userID: Int) {
        socket.handleEvent(MESSAGE_EVENT, data: [[
            "idMessage": id,
            "idUserMessage": userID,
            "messageText": "Hola",
            "userName": "Test User",
            "userImage": ""
        ]], isInternalMessage: true)
    }
}

private final class RecordingSocket: SocketIOClient {
    var connectCount = 0
    var emissions: [(event: String, items: [SocketData])] = []

    override func connect(withPayload payload: [String: Any]? = nil) {
        connectCount += 1
    }

    override func disconnect() {}

    override func emit(_ event: String, with items: [SocketData], completion: (() -> ())?) {
        emissions.append((event, items))
        completion?()
    }
}

private final class ChatUsersRepositoryStub: UsersRepository {
    func getLocalUser() -> Result<User, Error> {
        .success(User(
            id: 1, name: "Test", lastName: "User", totalScore: 0,
            ranking: 0, idEvent: 3, avatar: "avatar.png", token: ""
        ))
    }

    func getLocalUsers(predicate: NSPredicate?) -> Result<[User], Error> {
        fatalError("Not used by chat")
    }

    func createLocalUser(user: User) -> Result<Bool, Error> {
        fatalError("Not used by chat")
    }

    func updateLocalUserBy(avatarName: String) { fatalError("Not used by chat") }
    func deleteLocalAllUsers() -> Result<Bool, Error> { fatalError("Not used by chat") }
    func updateLocalTotalScoreOfUser(totalScore: Int) { fatalError("Not used by chat") }
    func updateLocalToken(token: String) { fatalError("Not used by chat") }

    func getRemoteUser(idUser: Int) -> AnyPublisher<User, ErrorResponse> {
        fatalError("Not used by chat")
    }

    func signOut(signOutRequest: SignOutRequest) -> AnyPublisher<Bool, ErrorResponse> {
        fatalError("Not used by chat")
    }

    func uploadProfileImage(profileImageURL: URL, userId: Int) -> AnyPublisher<ProfileImage, ErrorResponse> {
        fatalError("Not used by chat")
    }
}
