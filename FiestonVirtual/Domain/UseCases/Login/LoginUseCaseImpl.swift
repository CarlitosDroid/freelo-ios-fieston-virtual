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
    
    public init(eventCodeRepository: EventCodeRepository,
                usersRepository: UsersRepository) {
        self.eventCodeRepository = eventCodeRepository
        self.usersRepository = usersRepository
    }
    
    func invoke() -> AnyPublisher<EventCode, ErrorResponse> {
        return self.eventCodeRepository.verifyCode(userInvitationCode: 100510)
    }
}
