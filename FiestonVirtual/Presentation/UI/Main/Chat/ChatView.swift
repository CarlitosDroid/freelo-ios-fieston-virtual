//
//  ChatView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var socketIOViewModel = DependencyProvider().assembler.resolver.resolve(SocketIOViewModel.self)!
    @ObservedObject var chatViewModel = DependencyProvider().assembler.resolver.resolve(ChatViewModel.self)!
    
    @State private var chatMessages: [ChatMessage] = []
    
    @State var typingMessage: String = ""
    
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

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
