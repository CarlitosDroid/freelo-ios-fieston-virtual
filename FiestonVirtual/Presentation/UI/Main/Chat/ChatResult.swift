//
//  ChatResult.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

enum ChatResult {
    case GetMessages([ChatMessage])
    case GetMessagesError(String)
    case GetMessagesLoading(Bool)
    
    case SendOutgoingMessageSuccess(ChatMessage)
    case SendOutgoingMessageError(String)
}
