import SwiftUI
import Introspect

struct ChatView: View {
    
    @ObservedObject var socketIOViewModel = DependencyProvider().assembler.resolver.resolve(SocketIOViewModel.self)!
    @ObservedObject var chatViewModel = DependencyProvider().assembler.resolver.resolve(ChatViewModel.self)!
    
    @State private var chatMessages: [ChatMessage] = []
    
    @State var typingMessage: String = ""
    
    @State var scrollView: UIScrollView? = nil
    
    var body: some View {
        
        ZStack {
            
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                if(!self.chatMessages.isEmpty) {
                    ScrollView {
                        ForEach(chatMessages, id: \.self) { chatMessage in
                            switch(chatMessage.viewType) {
                            case ChatMessageViewType.INCOMING:
                                IncomingChatMessage(chatMessage: chatMessage)
                            case ChatMessageViewType.OUTGOING:
                                OutgoingChatMessage(chatMessage: chatMessage)
                            }
                        }
                    }.introspectScrollView { scrollView in
                        scrollView.scrollToBottom()
                        self.scrollView=scrollView
                    }
                    
                    HStack {
                        TextField("Mensaje...", text: self.$typingMessage)
                            .foregroundColor(Color.black)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.default)
                        Button(action: {
                            sendMessage(typingMessage: typingMessage)
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(Color.white)
                        }
                    }.padding(.all, 10)
                    
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
                self.chatMessages.append(chatMessage)
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
                self.chatMessages.append(chatMessage)
                break
            }
        }
    }
    
    func sendMessage(typingMessage: String) {
        
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
