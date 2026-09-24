//
//  ChatMessageRepositoryImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class ChatMessageRepositoryImpl: ChatMessageRepository {
    
    private let chatMessageDataSource: ChatMessageDataSource
    
    init(chatMessageDataSource: ChatMessageDataSource) {
        self.chatMessageDataSource = chatMessageDataSource
    }
    
    func getRemoteMessages(messageRequest: MessageRequest) -> AnyPublisher<[ChatMessage], ErrorResponse> {
        return self.chatMessageDataSource.getRemoteMessages(messageRequest: messageRequest)
    }
    
}
