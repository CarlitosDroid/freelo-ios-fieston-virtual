//
//  RespuestaTriviaResponse.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - RespuestaTriviaResponse
struct RespuestaTriviaResponse: Decodable {
    let message: String
    let data: ChildRespuestaTriviaDataResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildRespuestaTriviaDataResponse
struct ChildRespuestaTriviaDataResponse: Decodable {
    let userTotalScore: Int
    
    enum CodingKeys: String, CodingKey {
        case userTotalScore
    }
}
