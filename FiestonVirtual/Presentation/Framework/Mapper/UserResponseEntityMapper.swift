//
//  UserResponseEntityMapper.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

extension UserResponseEntity: DomainModel {
    
    typealias DomainModelType = User
    
    func toDomainModel() -> User {
        return User(
            name: self.data.user.userName,
            age: self.data.user.userLastName,
            isOld: false)
    }
    

    
//    return User(
//        id = i.idUser,
//        name = i.userName,
//        lastName = i.userLastName,
//        totalScore = i.userTotalScore,
//        ranking = i.userRanking,
//        idEvent = i.idEvent,
//        avatar = i.avatar
//    )
}
