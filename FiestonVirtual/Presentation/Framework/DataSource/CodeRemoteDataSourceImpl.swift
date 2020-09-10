//
//  CodeRemoteDataSourceImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class EventCodeRemoteDataSourceImpl: EventCodeRemoteDataSource {
   
    var eventCodeApi: EventCodeApi
    
    init(eventCodeApi: EventCodeApi) {
        self.eventCodeApi = eventCodeApi
    }

    func verificateEventCode(validateCodeRequest: ValidateCodeRequest) -> AnyPublisher<EventCode, ErrorResponse> {
        return eventCodeApi.validateCode(validateCodeRequest: validateCodeRequest)
            .mapError { (externalError: ExternalError) -> ErrorResponse in
                switch externalError {
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
            }
            .map { (codeVerificationResponse: CodeVerificationResponse) -> EventCode in
                return codeVerificationResponse.toEventCode()
            }.eraseToAnyPublisher()
    }
   
}
