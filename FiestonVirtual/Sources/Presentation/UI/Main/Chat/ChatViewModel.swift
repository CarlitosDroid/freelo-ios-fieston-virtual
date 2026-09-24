//
//  ChatViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class ChatViewModel : ObservableObject {
    
    private var getMessagesUseCase: GetChatMessagesUseCase
    private var sendChatMessageUseCase: SendChatMessageUseCase
    
    @Published var chatResult: ChatResult?
    
    private var disposables = Set<AnyCancellable>()
    
    init(getMessagesUseCase: GetChatMessagesUseCase, sendChatMessageUseCase: SendChatMessageUseCase) {
        self.getMessagesUseCase = getMessagesUseCase
        self.sendChatMessageUseCase = sendChatMessageUseCase
    }
    
    func getMessages() {
        self.chatResult = ChatResult.GetMessagesLoading(true)
        self.getMessagesUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.chatResult = ChatResult.GetMessagesLoading(false)
                switch completion {
                case .finished:
                    print("finish")
                    break
                case .failure(let errorResponse):
                    self.chatResult = ChatResult.GetMessagesError(errorResponse.localizedDescription)
                    break
                }
            }, receiveValue: { (chatMessages: [ChatMessage]) in
                self.chatResult = ChatResult.GetMessages(chatMessages)
            })
            .store(in: &disposables)
    }
    
    func sendMessage(chatMessage: String) {
        if(chatMessage.isEmpty) {
            self.chatResult = ChatResult.SendOutgoingMessageError("Mensaje Vacío")
            return
        }
        
        let sentChatMessage = sendChatMessageUseCase.invoke(chatMessage: chatMessage)
        self.chatResult = ChatResult.SendOutgoingMessageSuccess(sentChatMessage)
    }
    
}
