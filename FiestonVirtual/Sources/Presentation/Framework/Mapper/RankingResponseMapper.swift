//
//  RankingResponseMapper.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

extension RankingResponse: DomainModel {
    
    typealias DomainModelType = [Ranking]
    
    func toDomainModel() -> [Ranking] {
        return self.data.raking.map { (childRankingResponse: ChildRankingResponse) -> Ranking in
            Ranking(
                id: childRankingResponse.idUserRanking,
                userName: childRankingResponse.userRankingName,
                totalScore: childRankingResponse.userRankingTotalScore,
                position: childRankingResponse.userRankingPosition,
                userLogo: childRankingResponse.userRankingLogo)
        }
    }
}
