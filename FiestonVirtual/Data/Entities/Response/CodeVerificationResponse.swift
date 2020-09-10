//
//  CodeVerificationResponseEntity.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct CodeVerificationResponse: Codable {
    let message: String
    let data: CodeVerificationDataResponse?
}

// MARK: - CodeVerificationDataResponse
struct CodeVerificationDataResponse: Codable {
    let user: CodeVerificationUserResponse?
    let event: CodeVerificationEventResponse?
}

// MARK: - CodeVerificationEventResponse
struct CodeVerificationEventResponse: Codable {
    let idEvent: Int
}

// MARK: - CodeVerificationUserResponse
struct CodeVerificationUserResponse: Codable {
    let idUser: Int
}
