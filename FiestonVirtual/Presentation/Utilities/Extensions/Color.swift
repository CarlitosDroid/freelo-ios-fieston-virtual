//
//  Color.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff, opacity: 1)
        
    }
    
    static let deep_purple_intense = Color("deep_purple_intense")
    static let aqua = Color("Aqua")
    static let orange_500 = Color("orange_500")
    static let amber_600 = Color("amber_600")
    static let deep_purple_500 = Color("deep_purple_500")
    static let deep_purple_700 = Color("deep_purple_700")

}
