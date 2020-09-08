//
//  CodeVerificationResponseEntity.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct CodeVerificationResponseEntity: Codable {
    let message: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let user: UserResponse?
    let event: EventResponse?
}

// MARK: - Event
struct EventResponse: Codable {
    let idEvent: Int
}

// MARK: - User
struct UserResponse: Codable {
    let idUser: Int
}
