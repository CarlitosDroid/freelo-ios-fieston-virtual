//
//  CodeVerificationResponseEntity.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct CodeVerificationResponseEntity: Decodable {
    let message: String
    let data: DataClass?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - DataClass
struct DataClass: Decodable {
    let user: UserResponse
    let event: EventResponse
    enum CodingKeys: String, CodingKey {
        case user = "user"
        case event = "event"
    }
}

// MARK: - EventResponse
struct EventResponse: Decodable {
    let idEvent: Int
    enum CodingKeys: String, CodingKey {
        case idEvent = "idEvent"
    }
}

// MARK: - UserResponse
struct UserResponse: Decodable {
    let idUser: Int
    enum CodingKeys: String, CodingKey {
        case idUser = "idUser"
    }
}
