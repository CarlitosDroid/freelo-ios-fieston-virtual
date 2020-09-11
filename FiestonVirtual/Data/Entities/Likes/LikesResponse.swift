//
//  LikesResponse.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - LikesResponse
struct LikesResponse: Decodable {
    let message: String
    let data: ChildLikesDataResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildLikesDataResponse
struct ChildLikesDataResponse: Decodable {
    let userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes
    }
}
