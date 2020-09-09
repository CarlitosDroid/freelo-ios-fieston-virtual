//
//  EventCodeRepositoryImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class EventCodeRepositoryImpl: EventCodeRepository {

    let eventCodeRemoteDataSource: EventCodeRemoteDataSource
    
    init(eventCodeRemoteDataSource: EventCodeRemoteDataSource) {
        self.eventCodeRemoteDataSource = eventCodeRemoteDataSource
    }
    
    func verifyCode(userInvitationCode: Int) -> AnyPublisher<EventCode, ErrorResponse> {
        return eventCodeRemoteDataSource.verificateEventCode(userInvitationCode: userInvitationCode)
    }
    
    func getWelcome(welcomeRequest: WelcomeRequest) -> AnyPublisher<Welcome, ErrorResponse> {
        return self.eventCodeRemoteDataSource.getWelcome(welcomeRequest: welcomeRequest)
    }
    
}
