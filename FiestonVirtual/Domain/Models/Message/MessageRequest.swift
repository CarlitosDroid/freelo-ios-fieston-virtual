//
//  MessageRequest.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/13/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct MessageRequest: Encodable {
    let idUser: Int
    let idEvent: Int
}
