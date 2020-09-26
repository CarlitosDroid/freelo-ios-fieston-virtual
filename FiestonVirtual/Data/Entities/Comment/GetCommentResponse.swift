//
//  GetComentResponseEntity.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation


// MARK: - GetComentResponse
struct GetCommentResponse: Decodable {
    let message: String
    let data: ChildGetComentDataResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildGetComentDataResponse
struct ChildGetComentDataResponse: Decodable {
    let comments: [ChildGetCommentsResponse]
    enum CodingKeys: String, CodingKey {
        case comments
    }
}

// MARK: - ChildGetCommentsResponse
struct ChildGetCommentsResponse: Decodable {
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

