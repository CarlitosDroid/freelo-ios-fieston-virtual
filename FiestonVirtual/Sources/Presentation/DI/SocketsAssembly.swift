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
            var components = URLComponents()
            components.scheme = "http"
            components.host = APIConfiguration.host
            components.port = 8090
            return SocketManager(socketURL: components.url!, config: [.log(true), .compress])
        }
    }
    
}
