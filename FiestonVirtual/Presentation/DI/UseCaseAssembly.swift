//
//  UseCaseAssembly.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject

class UseCasesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LoginUseCase.self) { resolver in
            LoginUseCaseImpl(
                eventCodeRepository: resolver.resolve(EventCodeRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!)
        }
        container.register(VerifySessionUseCase.self) { resolver in
            VerifySessionUseCaseImpl(usersRepository: resolver.resolve(UsersRepository.self)!)
        }
        container.register(GetWelcomeUseCase.self) { resolver in
            GetWelcomeUseCaseImpl(
                eventRepository : resolver.resolve(EventCodeRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        container.register(SignOutUseCase.self) { resolver in
            SignOutUseCaseImpl(
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
    }
}
