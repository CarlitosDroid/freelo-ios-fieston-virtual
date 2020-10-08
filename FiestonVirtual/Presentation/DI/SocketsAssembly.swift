//
//  SocketsAssembly.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject
import SocketIO

class SocketsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SocketManager.self) { resolver in
            return SocketManager(socketURL: URL(string: "http://www.fiestonvirtual.com:8090")!, config: [.log(true), .compress])
        }
    }
    
}
