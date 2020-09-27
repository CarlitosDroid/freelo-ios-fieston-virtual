//
//  LikesApi.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol LikeApi {
    
    func makeLike(makeLikeRequest: MakeLikeRequest) ->
    AnyPublisher<LikesResponse,ExternalError>
    
}
