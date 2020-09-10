//
//  GetComentResponseEntity.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation


// MARK: - GetComentResponseEntity
struct GetComentResponseEntity: Decodable {
    let message: String
    let data: ChildDataComentResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildDataComentResponse
struct ChildDataComentResponse: Decodable {
    let comments: [Comment]
    enum CodingKeys: String, CodingKey {
        case comments
    }
}

// MARK: - Comment
struct Comment: Decodable {
    let idComment: Int
    let commentRegistrationDate, comment: String
    let avatar: String
    let commentStatus, idUserComment: Int
    let userComment: String
    
    enum CodingKeys: String, CodingKey {
        case idComment
        case commentRegistrationDate, comment
        case avatar
        case commentStatus, idUserComment
        case userComment
    }
}

