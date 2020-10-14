//
//  ChatMessage.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/13/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct ChatMessage: Hashable, Equatable {
    
    let idMessage: String
    let messageText: String
    let userName: String
    let userId: Int
    let userImage: String
    var viewType: ChatMessageViewType
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMessage)
    }
    
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        let areEqual = lhs.idMessage == rhs.idMessage
        
        return areEqual
    }

}
