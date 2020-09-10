//
//  Log.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

class Log {

    static func e(_ errorMessage: String) {
        print("📕: \(errorMessage)")
    }

    static func w(_ warningMessage: String) {
        print("📙: \(warningMessage)")
    }

    static func d(_ debugMessage: String) {
        print("📗: \(debugMessage)")
    }

    static func i(_ informationMessage: String) {
        print("📘: \(informationMessage)")
    }

    static func t(_ testMessage: String) {
        print("📓: \(testMessage)")
    }

    static func a(_ anyMessage: String) {
        print("📔: \(anyMessage)")
    }

}
