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
            id: Int(self.id),
            name: String(self.firstName ?? ""),
            lastName: String(self.lastName ?? ""),
            totalScore:Int(self.totalScore),
            ranking:Int(self.ranking),
            idEvent:Int(self.idEvent),
            avatar:String(self.avatar ?? ""),
            token:String(self.token ?? "")
        )
    }
    
}
