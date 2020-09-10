//
//  UserResponseEntity.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Decodable {
    let message: String
    let data: ChildUserDataResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildUserDataResponse
struct ChildUserDataResponse: Decodable {
    let user: ChildUserResponse
    enum CodingKeys: String, CodingKey {
        case user
    }
}

// MARK: - ChildUserResponse
struct ChildUserResponse: Decodable {
    let idUser, idEvent: Int
    let userName, userLastName, userSurName, userEmail: String
    let userPhone, userCell: String
    let userTotalScore, userStatus: Int
    let avatar: String
    let userLikesPhotos, userLikesVideos, userRanking: Int
    
    enum CodingKeys: String, CodingKey {
        case idUser
        case idEvent
        case userName
        case userLastName
        case userSurName
        case userEmail
        case userPhone
        case userCell
        case userTotalScore
        case userStatus
        case avatar
        case userLikesPhotos
        case userLikesVideos
        case userRanking
    }
}
