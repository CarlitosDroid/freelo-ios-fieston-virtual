//
//  ExternalError.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

enum ExternalError: Error {
    case Parsing(description: String)
    case NetworkError(description: String)
    case UnknowError(description: String)
}
