//
//  SocketIOViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON

class SocketIOViewModel : ObservableObject {
    
    let socketManager: SocketManager?
    let socket: SocketIOClient?
    let usersRepository: UsersRepository
    private var isListening = false
    private var currentUserID: Int?
    
    @Published var socketIOResult: SocketIOResult?
    
    init(
        usersRepository: UsersRepository,
        socketManager: SocketManager? = DependencyProvider().assembler.resolver.resolve(SocketManager.self)
    ) {
        self.socketManager = socketManager
        self.socket = socketManager?.defaultSocket
        self.usersRepository = usersRepository
    }
    
    func startListeners() {
        guard !isListening else { return }
        guard let socket = socket else {
            print("Socket.IO start failed: socket is unavailable")
            socketIOResult = .ConnectionError(true)
            return
        }
        isListening = true
        socket.on(clientEvent: .error, callback: { [weak self] data, ack in
            guard let self = self else { return }
            
            print(data)
            self.socketIOResult = SocketIOResult.ConnectionError(true)
            
        })
        socket.on(clientEvent: .connect, callback: { [weak self] data, ack in
            guard let self = self else { return }
            switch self.usersRepository.getLocalUser() {
            case .success(let user):
                self.currentUserID = user.id
                print("Socket.IO join event: \(user.idEvent), user: \(user.id)")
                self.socket?.emit(JOIN_EVENT, [
                    "idEvent": user.idEvent,
                    "idUser": user.id,
                    "userName": "\(user.name) \(user.lastName)",
                    "userImage": user.avatar
                ])
            case .failure(let error):
                print("Socket.IO join failed: \(error.localizedDescription)")
                self.socketIOResult = .ConnectionError(true)
                return
            }
            self.socketIOResult = SocketIOResult.ConnectionSuccess(true)
            
        })
        socket.on(clientEvent: .disconnect, callback: { [weak self] data, ack in
            guard let self = self else { return }
            self.currentUserID = nil
            
            self.socketIOResult = SocketIOResult.ConnectionDisconnect(true)
            
        })
        
        socket.on(MESSAGE_EVENT, callback: { [weak self] data, ack in
            guard let self = self else { return }
            guard let payload = data.first else {
                print("Socket.IO message rejected: missing payload")
                self.socketIOResult = .ConnectionError(true)
                return
            }
            let json = JSON(payload)
            guard let idMessage = json["idMessage"].string, !idMessage.isEmpty,
                  let idUserMessage = json[ID_USER_KEY].int,
                  let messageText = json[MESSAGE_KEY].string,
                  let currentUserID = self.currentUserID else {
                print("Socket.IO message rejected: invalid message or missing user session")
                self.socketIOResult = .ConnectionError(true)
                return
            }
            print("Socket.IO message received: id=\(idMessage), user=\(idUserMessage)")
            let userImage = json[USER_IMAGE_KEY].stringValue
            let userName = json[USERNAME_KEY].stringValue
            
            let chatMessage =
                ChatMessage(
                    idMessage: idMessage,
                    messageText: messageText,
                    userName: userName,
                    userId: idUserMessage,
                    userImage: userImage,
                    viewType: idUserMessage == currentUserID
                        ? .OUTGOING(value: 2)
                        : .INCOMING(value: 1)
                )
            self.socketIOResult = SocketIOResult.ReceiveIncomingMessageSuccess(chatMessage)
            
        
        })
        
        socket.connect()
    }
    
    func stopListeners() {
        guard isListening else { return }
        isListening = false
        self.socket?.off(clientEvent: .connect)
        self.socket?.off(clientEvent: .disconnect)
        self.socket?.off(clientEvent: .error)
        self.socket?.off(MESSAGE_EVENT)
        self.socket?.disconnect()
        currentUserID = nil
        socketIOResult = nil
    }
    
    func sendMessage(message: String) {
        print("Socket.IO sending message")
        self.socket?.emit(MESSAGE_EVENT, message)
    }
    
}

let MESSAGE_EVENT = "message"
let JOIN_EVENT = "join"
let MESSAGE_KEY = "messageText"
let USERNAME_KEY = "userName"
let ID_USER_KEY = "idUserMessage"
let USER_IMAGE_KEY = "userImage"
