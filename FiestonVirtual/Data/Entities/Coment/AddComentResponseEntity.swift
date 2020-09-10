//
//  AddComentResponseEntity.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - AddComentResponseEntity
struct AddComentResponseEntity: Decodable {
    let message: String
    let data: ChildDataAddComentResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildDataAddComentResponse
struct ChildDataAddComentResponse: Decodable {
    let comment: ChildAddCommentResponse
    enum CodingKeys: String, CodingKey {
        case comment
    }
}

// MARK: - ChildAddCommentResponse
struct ChildAddCommentResponse: Decodable {
    let comment, commentRegistrationDate: String
    let idComment, commentStatus, idUserComment: Int
    let avatar: String
    let userComment: String
    
    enum CodingKeys : String, CodingKey {
        case comment, commentRegistrationDate
        case idComment, commentStatus, idUserComment
        case avatar
        case userComment
    }
}
