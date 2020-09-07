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
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let user: User
    let event: Event
}

// MARK: - Event
struct Event: Codable {
    let idEvent: Int
}

// MARK: - User
struct User: Codable {
    let idUser: Int
}
