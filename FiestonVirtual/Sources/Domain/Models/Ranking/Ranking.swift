//
//  Ranking.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct Ranking : Encodable, Identifiable{
    let id: Int
    let userName: String
    let totalScore: Int
    let position: Int
    let userLogo: String
}
