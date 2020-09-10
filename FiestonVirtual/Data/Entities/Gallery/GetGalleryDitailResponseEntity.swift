//
//  GetGalleryDitailResponceEntity.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - GetGalleryDitailResponceEntity
struct GetGalleryDitailResponceEntity: Decodable {
    let message: String
    let data: ChildDataGalleryDitailResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildDataGalleryDitailResponse
struct ChildDataGalleryDitailResponse: Decodable {
    let post: Post
    let user: User
    enum CodingKeys: String, CodingKey {
        case post
        case user
    }
}

// MARK: - Post
struct Post: Decodable {
    let idPost, postType: Int
    let postFile: String
    let postTitle: String
    let postStatus, postLikeCount: Int
    let postLike: Bool
    
    enum CodingKeys: String, CodingKey {
        case idPost, postType
        case postFile
        case postTitle
        case postStatus, postLikeCount
        case postLike
    }
}

// MARK: - User
struct User: Decodable {
    let userName: String
    let userImage: String
    
    enum CodingKeys: String, CodingKey {
        case userName
        case userImage
    }
}
