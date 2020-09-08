//
//  UserEntityMapper.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

extension UserEntity: DomainModel {
    
    typealias DomainModelType = User
    
    func toDomainModel() -> User {
        return User(
            name: self.name ?? "CARLITOS",
            age: self.age ?? "100",
            isOld: false)
    }
  
}
