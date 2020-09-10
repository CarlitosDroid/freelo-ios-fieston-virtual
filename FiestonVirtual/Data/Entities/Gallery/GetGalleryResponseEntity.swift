//
//  GetGalleryResponceEntity.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - GetGalleryResponceEntity
struct GetGalleryResponceEntity: Decodable {
    let message: String
    let data:   ChildDataGalleryResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildDataGalleryResponse
struct ChildDataGalleryResponse: Decodable {
    let posts: [Post]
    enum CodingKey: String, CodingKey {
        case posts
    }
}

// MARK: - Post
struct Post: Decodable {
    let idPost, postType: Int
    let postFile: String
    let preview: String
    let postStatus: Int
    
    enum CodingKey: String, CodingKeys {
        case idPost, postType
        case postFile
        case preview
        case postStatus
    }
}
