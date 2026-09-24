//
//  GetGalleryDitailResponceEntity.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - GetGalleryDetailResponse
struct GetGalleryDetailResponse: Decodable {
    let message: String
    let data: ChildGetGalleryDetailDataResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildGetGalleryDetailDataResponse
struct ChildGetGalleryDetailDataResponse: Decodable {
    let post: ChildGetGalleryPostResponse
    let user: ChildGetGalleryUserResponse
    enum CodingKeys: String, CodingKey {
        case post
        case user
    }
}

// MARK: - ChildGetGalleryPostResponse
struct ChildGetGalleryPostResponse: Decodable {
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

// MARK: - ChildGetGalleryUserResponse
struct ChildGetGalleryUserResponse: Decodable {
    let userName: String
    let userImage: String
    
    enum CodingKeys: String, CodingKey {
        case userName
        case userImage
    }
}
