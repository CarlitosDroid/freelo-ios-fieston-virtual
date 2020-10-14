//
//  ChatMessageDataSourceImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/13/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class ChatMessageDataSourceImpl : ChatMessageDataSource {
    
    private let chatMessagesApi: ChatMessagesApi
    private let usersRepository: UsersRepository
    
    init(chatMessagesApi: ChatMessagesApi, usersRepository: UsersRepository){
        self.chatMessagesApi = chatMessagesApi
        self.usersRepository = usersRepository
    }
    
    func getRemoteMessages(messageRequest: MessageRequest) -> AnyPublisher<[ChatMessage], ErrorResponse> {
        return self.chatMessagesApi.getMessages(messageRequest: messageRequest)
            .mapError{ (externalError: ExternalError) -> ErrorResponse in
                switch externalError {
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
            }
            .map{ (messagesResponse : MessagesResponse) -> [ChatMessage] in
                
                switch self.usersRepository.getLocalUser() {
                
                case .success(let user):
                    
                    return messagesResponse.toDomainModel(user: user)
                        
                case .failure(let error):
                    return [ChatMessage]()
                }
                
            }.eraseToAnyPublisher()
    }
    
}
