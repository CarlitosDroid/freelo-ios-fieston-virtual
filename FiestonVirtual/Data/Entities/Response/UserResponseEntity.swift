//
//  UserResponseEntity.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - UserResponseEntity
struct UserResponseEntity: Codable {
    let data: ChildDataUserResponse
    let message: String
}

// MARK: - ChildDataUserResponse
struct ChildDataUserResponse: Codable {
    let user: ChildUserResponse
}

// MARK: - ChildUserResponse
struct ChildUserResponse: Codable {
    let idUser, idEvent: Int
    let userName, userLastName, userSurName, userEmail: String
    let userPhone, userCell: String
    let userTotalScore, userStatus: Int
    let avatar: String
    let userLikesPhotos, userLikesVideos, userRanking: Int
}
