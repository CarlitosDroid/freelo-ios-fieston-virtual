//
//  LikesResponse.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct LikeResponse: Decodable {
    let message: String
    let data: ChildLikeDataResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

struct ChildLikeDataResponse: Decodable {
    let userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes
    }
}
