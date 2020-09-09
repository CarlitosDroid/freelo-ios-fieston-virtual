//
//  CodeRemoteDataSource.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol EventCodeRemoteDataSource {
    func verificateEventCode(userInvitationCode: Int) -> AnyPublisher<EventCode, ErrorResponse>
    func getWelcome (welcomeRequest: WelcomeRequest) -> AnyPublisher<Welcome, ErrorResponse>
}
