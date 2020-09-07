//
//  ErrorResponse.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct ErrorResponse: Error {
    var code: Int = 0
    var title: String
    var message: String
    init(code: Int = 0, title: String, message: String) {
        self.code = code
        self.title = title
        self.message = message
    }
}
