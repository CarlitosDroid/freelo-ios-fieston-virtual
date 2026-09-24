//
//  String.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/4/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

func getCurrentTimeStamp() -> String {
    let now = Date()
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyyMMddHHmmss"
    return formatter.string(from: now)
}
