//
//  MessagesResponse.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/13/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct MessagesResponse: Decodable {
    let message: String
    let data: ChildDataMessagesResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - DataClass
struct ChildDataMessagesResponse: Decodable {
    let messages: [ChildMessageResponse]
    
    enum CodingKeys: String, CodingKey {
        case messages = "messages"
    }
}

// MARK: - Message
struct ChildMessageResponse: Decodable {
    let idMessage: Int
    let messageRegistrationDate, messageText: String
    let idUserMessage: Int
    let userMessage: String
    let userImage: String
}
