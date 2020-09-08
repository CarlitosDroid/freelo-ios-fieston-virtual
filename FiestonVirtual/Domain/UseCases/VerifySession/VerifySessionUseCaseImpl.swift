//
//  VerifySessionUseCaseImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

class VerifySessionUseCaseImpl: VerifySessionUseCase {
    
    let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func invoke() -> Result<[User], Error> {
        let filter = "carlitosdroid"
        let commitPredicate = NSPredicate(format: "name == %@", filter)
        
        return self.usersRepository.getLocalUsers(predicate: commitPredicate)
    }
    
}

