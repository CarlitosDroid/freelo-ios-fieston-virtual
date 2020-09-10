//
//  RankingResponseEntity.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - RankingResponse
struct RankingResponse: Decodable {
    let message: String
    let data: ChildRankingDataResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

//MARK: - ChildRankingDataResponse
struct ChildRankingDataResponse: Decodable {
    let raking: [ChildRankingResponse]
    let userTotalScore: String
    enum CodingKeys: String, CodingKey{
        case raking
        case userTotalScore
    }
}

//MARK: - ChildRankingResponse
struct ChildRankingResponse: Decodable {
    let idUserRanking: Int
    let userRankingName: String
    let userRankingTotalScore: Int
    let userRankingPosition: Int
    let userRankingLogo: String
    
    
    enum CodingKeys: String, CodingKey{
        case idUserRanking
        case userRankingName
        case userRankingTotalScore
        case userRankingPosition
        case userRankingLogo
    }
    
}
