//
//  RankingResponseEntity.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - RankingResponseEntity
struct RankingResponseEntity: Decodable {
    let message: String
    let data: ChildDataRankingResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

//MARK: - ChildDataRankingResponse
struct ChildDataRankingResponse: Decodable {
    let ranking: [ChildRankingResponce]
    let userTotalScore: String
    enum CodingKeys: String, CodingKey{
        case ranking
        case userTotalScore
    }
}

//MARK: - ChildRankingResponse
struct ChildRankingResponce: Decodable {
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
