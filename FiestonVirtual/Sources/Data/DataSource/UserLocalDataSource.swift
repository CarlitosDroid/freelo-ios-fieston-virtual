//
//  UserLocalDataSource.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol UserLocalDataSource {
    func saveUser()
    func getUsers()
}

