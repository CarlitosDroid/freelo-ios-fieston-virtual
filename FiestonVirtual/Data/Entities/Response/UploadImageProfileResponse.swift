//
//  UploadImageProfileResponse.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/4/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct UploadImageProfileResponse: Decodable {
    let message: String
    let data: ChildUploadImageProfileDataResponse
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - DataClass
struct ChildUploadImageProfileDataResponse: Decodable {
    let post: ChildUploadImageProfilePostResponse
    enum CodingKeys: String, CodingKey {
        case post = "post"
    }
}

// MARK: - Post
struct ChildUploadImageProfilePostResponse: Decodable {
    let idPost: Int
    let postFile: String
    let postType: Int
    enum CodingKeys: String, CodingKey {
        case idPost = "idPost"
        case postFile = "postFile"
        case postType = "postType"
    }
}
