//
//  SendChatMessageUseCaseImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/13/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

class SendChatMessageUseCaseImpl: SendChatMessageUseCase {
    
    private let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func invoke(chatMessage: String) -> ChatMessage {
        
        switch self.usersRepository.getLocalUser() {
        
        case .success(let user):
    
            return ChatMessage(
                idMessage: UUID().uuidString,
                messageText: chatMessage,
                userName: "\(user.name) \(user.lastName)",
                userId: user.id,
                userImage: user.avatar,
                viewType: ChatMessageViewType.OUTGOING(value: 2)
            )
            
        case .failure(let error):
            return ChatMessage(idMessage: "1", messageText: "", userName: "", userId: 0, userImage: "", viewType: ChatMessageViewType.INCOMING(value: 1))
        }
    }
    
}
