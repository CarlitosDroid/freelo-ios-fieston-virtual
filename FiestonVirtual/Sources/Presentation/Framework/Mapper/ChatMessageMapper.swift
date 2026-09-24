//
//  ChatMessageMapper.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/13/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

extension MessagesResponse {
    
    func toDomainModel(user: User) -> [ChatMessage] {
        self.data.messages.map { (childMessageResponse: ChildMessageResponse) -> ChatMessage in
            
            var viewTypee: ChatMessageViewType
            if(childMessageResponse.idUserMessage == user.id) {
                viewTypee = ChatMessageViewType.OUTGOING(value: 2)
            } else {
                viewTypee = ChatMessageViewType.INCOMING(value: 1)
            }
            
            return ChatMessage(
                idMessage: String(childMessageResponse.idMessage),
                messageText: childMessageResponse.messageText,
                userName: childMessageResponse.userMessage,
                userId: childMessageResponse.idUserMessage,
                userImage: childMessageResponse.userImage,
                viewType: viewTypee
            )
        }
    }
}
