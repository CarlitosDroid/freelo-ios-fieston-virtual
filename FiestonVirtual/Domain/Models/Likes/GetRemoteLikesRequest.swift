//
//  GetRemoteLikesRequest.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct GetRemoteLikesRequest: Encodable {
    let idUserSesion: Int
    let idPost: Int
}
