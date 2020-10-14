//
//  GetMessagesUseCaseImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/13/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class GetChatMessagesUseCaseImpl: GetChatMessagesUseCase {
    
    private let chatMessageRepository: ChatMessageRepository
    private let usersRepository: UsersRepository
    
    init(chatMessageRepository: ChatMessageRepository, usersRepository: UsersRepository) {
        self.chatMessageRepository = chatMessageRepository
        self.usersRepository = usersRepository
    }
    
    func invoke() -> AnyPublisher<[ChatMessage], ErrorResponse> {
        
        switch self.usersRepository.getLocalUser() {
        
        case .success(let user):
            let messageRequest = MessageRequest(idUser: user.id, idEvent: user.idEvent)
            
            return self.chatMessageRepository.getRemoteMessages(
                messageRequest: messageRequest
            )
        case .failure(let error):
            return Just([ChatMessage]())
                .mapError({ (_) in
                    ErrorResponse(code: 1, title: "", message: error.localizedDescription)
                }).eraseToAnyPublisher()
            
        }
    }
    
}
