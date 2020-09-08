//
//  LoginUseCaseImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class LoginUseCaseImpl: LoginUseCase {
    
    let eventCodeRepository: EventCodeRepository
    let usersRepository: UsersRepository
    
    init(eventCodeRepository: EventCodeRepository,
         usersRepository: UsersRepository) {
        self.eventCodeRepository = eventCodeRepository
        self.usersRepository = usersRepository
    }
    
    func invoke() -> AnyPublisher<Bool, ErrorResponse> {
        
        // request verify code
        return self.eventCodeRepository.verifyCode(userInvitationCode: 100510)
            .flatMap { (eventCode: EventCode) -> AnyPublisher<Bool, ErrorResponse> in
                
                // request romte user
                return self.usersRepository.getRemoteUser(idUser: eventCode.idUser).flatMap { (user: User) -> AnyPublisher<Bool, ErrorResponse> in
                    
                    //save to disk
                    let result = self.usersRepository.create(user: user)
                    switch result {
                    case .success(let isSaved):
                        print("was saved: \(isSaved)")
                        return Just(true).mapError({ (_) in
                            ErrorResponse(code: 1, title: "", message: "")
                        }).eraseToAnyPublisher()
                    case .failure(let error):
                        print(error)
                        return Just(false).mapError({ (_) in
                            ErrorResponse(code: 1, title: "", message: "")
                        }).eraseToAnyPublisher()
                    }
        
                }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
