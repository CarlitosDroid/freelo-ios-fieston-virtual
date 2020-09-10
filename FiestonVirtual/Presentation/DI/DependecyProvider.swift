//
//  DependecyProvider.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject

class DependencyProvider {
    
    let container = Container()
    let assembler: Assembler
    
    init() {
        assembler = Assembler([
            ApiAssembly(),
            DataSourcesAssembly(),
            DataSourcesAssembly(),
            RepositoriesAssembly(),
            UseCasesAssembly(),
            ViewModelAssembly()
        ], container: container)
    }
}
