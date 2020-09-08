//
//  RepositoriesAssembly.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject

class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(EventCodeRepository.self) { resolver in
            EventCodeRepositoryImpl(eventCodeRemoteDataSource: resolver.resolve(EventCodeRemoteDataSource.self)!)
        }
    }
}
