//
//  RankingApi.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol RankingApi {
    func getRankingData(idUser: Int, idEvent: Int ) ->
    AnyPublisher<RankingResponseEntity,ExternalError>
}
