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
    
    func invoke() -> Result<Bool, Error> {
        
        //TODO - use a predicate if we need to make querys
        //let filter = "carlitosdroid"
        //let commitPredicate = NSPredicate(format: "name == %@", filter)
        
        let result = self.usersRepository.getLocalUsers(predicate: nil)
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let users):
            return .success(!users.isEmpty)
        }
    }
}
