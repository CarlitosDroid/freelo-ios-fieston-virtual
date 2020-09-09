//
//  RankingRequest.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct GetRemoteRankingRequest: Encodable {
    let idUser: Int
    let idEvent: Int
}
