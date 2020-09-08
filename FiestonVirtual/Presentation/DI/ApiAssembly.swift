//
//  ApiAssembly.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject

class ApiAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UserApi.self) { (resolver: Resolver) in
            UserApiImpl()
        }
        
        container.register(EventCodeApi.self) { (resolver: Resolver) in
            EventCodeApiImpl()
        }
    }
    
}
