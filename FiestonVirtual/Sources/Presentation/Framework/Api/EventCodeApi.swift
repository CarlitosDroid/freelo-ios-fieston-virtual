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
    func validateCode(validateCodeRequest: ValidateCodeRequest) -> AnyPublisher<CodeVerificationResponse,ExternalError>
    func getWelcome(welcomeRequest: WelcomeRequest) -> AnyPublisher<WelcomeResponseEntity, ExternalError>
}
