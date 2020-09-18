//
//  UploadFileResponse.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - UploadImageResponse
struct UploadImageResponse: Decodable {
    let message: String
    let data: ChildUploadImageDataResponse
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildUploadImageDataResponse
struct ChildUploadImageDataResponse: Decodable {
    let post: ChildUploadImagePostResponse
    enum CodingKeys: String, CodingKey {
        case post = "post"
    }
}

// MARK: - ChildUploadImagePostResponse
struct ChildUploadImagePostResponse: Decodable {
    let idPost: Int
    let postFile: String
    let postType: Int
    let postTitle: String
    enum CodingKeys: String, CodingKey {
        case idPost = "idPost"
        case postFile = "postFile"
        case postType = "postType"
        case postTitle = "postTitle"
    }
}
