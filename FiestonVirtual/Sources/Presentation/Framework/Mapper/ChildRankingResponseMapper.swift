//
//  ChildRankingResponseMapper.swift
//  FiestonVirtual
//
//  Created by Everis on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

extension ChildRankingResponse{
    
    func toRanking() -> Ranking {
        
        return Ranking(
            id: self.idUserRanking,
            userName: self.userRankingName,
            totalScore: self.userRankingTotalScore,
            position: self.userRankingPosition,
            userLogo: self.userRankingLogo
        )
        
    }
    
}
