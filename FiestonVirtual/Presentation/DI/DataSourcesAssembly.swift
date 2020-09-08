//
//  DataSourcesAssembly.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject

class DataSourcesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UserRemoteDataSource.self) { (resolver: Resolver) in
            UserRemoteDataSourceImpl(userApi: resolver.resolve(UserApi.self)!)
        }
        
        container.register(UserLocalDataSource.self) { (resolver: Resolver) in
            UserLocalDataSourceImpl()
        }
    }
    
}
