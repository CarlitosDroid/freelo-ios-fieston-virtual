//
//  ValidateCodeRequest.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct ValidateCodeRequest: Encodable {
    let userInvitationCode: Int
}
