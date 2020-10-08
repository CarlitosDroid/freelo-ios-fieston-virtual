//
//  GetRemotePedirCancionRequest.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct GetRemotePedirCancionRequest: Encodable {
    let idUser: Int
    let idPlaylist: Int
}
