//
//  RankingRemoteDataSourceImpl.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class RankingRemoteDataSourceImpl: RankingRemoteDataSource {
    
    private let rankingApi: RankingApi
    
    init(rankingApi: RankingApi) {
        self.rankingApi = rankingApi
    }
    
    func getRanking(getRemoteRankingRequest: GetRemoteRankingRequest) -> AnyPublisher<GetRankingResponse, ErrorResponse> {
        return rankingApi.getRankingData(getRemoteRankingRequest: getRemoteRankingRequest)
            .mapError { (externalError: ExternalError) -> ErrorResponse in
                switch externalError {
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
            }
            .map { (rankingResponseEntity: RankingResponse) -> GetRankingResponse in
                return GetRankingResponse(
                    ranking : rankingResponseEntity.data.raking.map{ ranking in
                        ranking.toRanking()
                    } ,
                    userTotalScore: rankingResponseEntity.data.userTotalScore
                )
            }.eraseToAnyPublisher()
        
    }
}
