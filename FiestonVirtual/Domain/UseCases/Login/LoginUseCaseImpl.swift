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
    
    func invoke(userInvitationCode: Int) -> AnyPublisher<Bool, ErrorResponse> {
        
        // request verify code
        let validateCodeRequest = ValidateCodeRequest(userInvitationCode: userInvitationCode)
        
        return self.eventCodeRepository.verifyCode(validateCodeRequest: validateCodeRequest)
            .flatMap { (eventCode: EventCode) -> AnyPublisher<Bool, ErrorResponse> in
                
                // request romte user
                return self.usersRepository.getRemoteUser(idUser: eventCode.idUser).flatMap { (user: User) -> AnyPublisher<Bool, ErrorResponse> in
                    
                    //save to disk
                    let result = self.usersRepository.createLocalUser(user: user)
                    switch result {
                    case .success( _):
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
