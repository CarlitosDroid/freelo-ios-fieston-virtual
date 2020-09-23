//
//  GetGalleryResponceEntity.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - GetGalleryResponse
struct GetGalleryResponse: Decodable {
    let data: ChildGetGalleryDataResponse
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildGetGalleryDataResponse
struct ChildGetGalleryDataResponse: Decodable {
    let posts: [ChildGetGalleryPostsResponse]
    enum CodingKeys: String, CodingKey {
        case posts
    }
}

// MARK: - ChildGetGalleryPostsResponse
struct ChildGetGalleryPostsResponse: Decodable {
    let idPost : Int
    let postFile: String
    let postStatus: Int
    let postType: Int
    let preview: String
    
    enum CodingKeys: String, CodingKey {
        case idPost
        case postType
        case postFile
        case preview
        case postStatus
    }
}
