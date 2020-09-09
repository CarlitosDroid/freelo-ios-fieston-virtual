//
//  EventCodeApiImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class EventCodeApiImpl: EventCodeApi {
    
    func validateCode(userInvitationCode: Int) -> AnyPublisher<CodeVerificationResponseEntity, ExternalError> {
        
        let validateCodeRequest = ValidateCodeRequest(userInvitationCode: userInvitationCode)
        
        guard let url = makeVerifyCodeComponents().url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: validateCodeRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: CodeVerificationResponseEntity.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<CodeVerificationResponseEntity, AFError>)-> AnyPublisher<CodeVerificationResponseEntity, ExternalError> in
                Future<CodeVerificationResponseEntity, ExternalError> { promise in
                    switch dataResponse.result {
                        
                    case .failure(let afError):
                        promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                        break
                        
                    case .success(let userResponseEntity):
                        promise(.success(userResponseEntity))
                        break
                    }
                    
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
        
    }
    
   
    
}

private extension EventCodeApiImpl {
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
        static let key = "<your key>"
    }
    
    func makeVerifyCodeComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/consulta_codigo.php"
        return urlComponents
    }

}
