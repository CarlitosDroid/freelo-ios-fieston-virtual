//
//  LikesApi.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol LikesApi {
    func getLikesData(getRemoteLikesRequest:GetRemoteLikesRequest) ->
    AnyPublisher<LikesResponse,ExternalError>
}
