import SwiftUI
import Introspect

struct ChatView: View {
    
    @StateObject var socketIOViewModel = DependencyProvider().assembler.resolver.resolve(SocketIOViewModel.self)!
    @StateObject var chatViewModel = DependencyProvider().assembler.resolver.resolve(ChatViewModel.self)!
    
    @State private var chatMessages: [ChatMessage] = []
    
    @State var typingMessage: String = ""
    
    @State var scrollView: UIScrollView? = nil
    
    var body: some View {
        
        ZStack {

            LinearGradient(
                colors: [
                    Color.loginGradientStart,
                    Color.loginGradientMiddle,
                    Color.loginGradientEnd
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                HStack(spacing: 7) {
                    Image(systemName: "party.popper")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(hex: "36FFC4"))
                    Text("chat.event_banner")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color(hex: "D8D8DC"))
                }
                .padding(.horizontal, 14)
                .frame(height: 31)
                .background(
                    Capsule()
                        .fill(Color(hex: "282B31").opacity(0.9))
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                        )
                )
                .padding(.top, 16)
                .padding(.bottom, 12)
                
                if(!self.chatMessages.isEmpty) {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 18) {
                            ForEach(chatMessages, id: \.self) { chatMessage in
                                switch(chatMessage.viewType) {
                                case ChatMessageViewType.INCOMING:
                                    IncomingChatMessage(chatMessage: chatMessage)
                                case ChatMessageViewType.OUTGOING:
                                    OutgoingChatMessage(chatMessage: chatMessage)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                    }.introspectScrollView { scrollView in
                        scrollView.scrollToBottom()
                        self.scrollView=scrollView
                    }
                    
                    HStack(spacing: 12) {
                        Image(systemName: "face.smiling")
                            .font(.system(size: 22))
                            .foregroundColor(Color(hex: "D0CBD6"))

                        TextField("chat.message_placeholder", text: self.$typingMessage)
                            .font(.system(size: 15))
                            .foregroundColor(Color(hex: "E4E1E7"))
                            .accentColor(Color(hex: "36FFC4"))
                            .keyboardType(.default)

                        Image(systemName: "paperclip")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color(hex: "D0CBD6"))

                        Button(action: {
                            sendMessage(typingMessage: typingMessage)
                        }) {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(Color(hex: "071413"))
                                .frame(width: 50, height: 50)
                                .background(Circle().fill(Color(hex: "36FFC4")))
                                .shadow(color: Color(hex: "36FFC4").opacity(0.42), radius: 12)
                        }
                    }
                    .padding(.leading, 14)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color(hex: "11191A").opacity(0.92))
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    
                } else {
                    LoadingView(isShowing: .constant(true)) {
                        EmptyView()
                    }
                }
                
            }
        }
        .onAppear {
            self.chatViewModel.getMessages()
            self.socketIOViewModel.startListeners()
        }.onDisappear {
            self.socketIOViewModel.stopListeners()
        }
        .onReceive(self.chatViewModel.$chatResult) { (chatResult: ChatResult?) in
            
            guard let chatResult = chatResult else { return }
            
            switch chatResult {
            case .GetMessages(let chatMessages):
                
                self.chatMessages.removeAll()
                self.chatMessages.append(contentsOf: chatMessages)
                
                break
            case .GetMessagesError(let errorMessage):
                print(errorMessage)
                break
            case .GetMessagesLoading(let isLoading):
                
                break
            case .SendOutgoingMessageSuccess(let chatMessage):
                
                self.typingMessage = ""
                self.socketIOViewModel.sendMessage(message: chatMessage.messageText)
                self.scrollView?.scrollToBottom()
                break
            case .SendOutgoingMessageError(let errorMessage):
                print(errorMessage)
                break
            }
        }.onReceive(self.socketIOViewModel.$socketIOResult) { (socketIOResult: SocketIOResult?) in
            guard let socketIOResult = socketIOResult else { return }
            switch socketIOResult {
            case .ConnectionSuccess(let success):
                print("ConnectionSuccess")
                break
            case .ConnectionLoading(let success):
                print("ConnectionLoading")
                break
            case .ConnectionTimeout(let success):
                print("ConnectionTimeout")
                break
            case .ConnectionError(let success):
                print("ConnectionError")
                break
            case .ConnectionDisconnect(let success):
                print("ConnectionDisconnect")
                break
                
            case .ReceiveIncomingMessageSuccess(let chatMessage):
                if !self.chatMessages.contains(where: { $0.idMessage == chatMessage.idMessage }) {
                    self.chatMessages.append(chatMessage)
                    self.scrollView?.scrollToBottom()
                }
                break
            }
        }
    }
    
    func sendMessage(typingMessage: String) {
        guard !typingMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        self.chatViewModel.sendMessage(chatMessage: typingMessage)
    }
}

extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
