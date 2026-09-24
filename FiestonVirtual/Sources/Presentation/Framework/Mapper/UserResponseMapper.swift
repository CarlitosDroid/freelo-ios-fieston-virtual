//
//  UserResponseEntityMapper.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

extension UserResponse: DomainModel {
    
    typealias DomainModelType = User
    
    func toDomainModel() -> User {
        return User(
            id:self.data.user.idUser,
            name: self.data.user.userName,
            lastName: self.data.user.userLastName,
            totalScore: self.data.user.userTotalScore,
            ranking: self.data.user.userRanking,
            idEvent: self.data.user.idEvent,
            avatar: self.data.user.avatar,
            token: ""
        )
    }

}
