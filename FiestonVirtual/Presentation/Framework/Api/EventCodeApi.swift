//
//  EventCodeApi.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol EventCodeApi {
    func validateCode(userInvitationCode: Int) -> AnyPublisher<CodeVerificationResponseEntity,ExternalError>
    func getWelcome(welcomeRequest: WelcomeRequest) -> AnyPublisher<WelcomeResponseEntity, ExternalError>

}
