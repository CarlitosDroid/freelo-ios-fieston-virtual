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
   
    let loginUseCase = DependencyProvider().assembler.resolver.resolve(EventCodeRemoteDataSource.self)!
    let eventCodeRemoteDataSource: EventCodeRemoteDataSource
    
    init(eventCodeRemoteDataSource: EventCodeRemoteDataSource) {
        self.eventCodeRemoteDataSource = eventCodeRemoteDataSource
    }
    
    func verifyCode(validateCodeRequest: ValidateCodeRequest) -> AnyPublisher<EventCode, ErrorResponse> {
        return eventCodeRemoteDataSource.verificateEventCode(validateCodeRequest: validateCodeRequest)
    }

}
