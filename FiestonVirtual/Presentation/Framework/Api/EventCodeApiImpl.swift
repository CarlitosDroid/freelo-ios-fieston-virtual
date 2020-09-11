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
    
    func validateCode(validateCodeRequest: ValidateCodeRequest) -> AnyPublisher<CodeVerificationResponse, ExternalError> {
    
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
            .publishDecodable(type: CodeVerificationResponse.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<CodeVerificationResponse, AFError>)-> AnyPublisher<CodeVerificationResponse, ExternalError> in
                Future<CodeVerificationResponse, ExternalError> { promise in
                    switch dataResponse.result {

                    case .failure(let afError):
                        promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                        break

                    case .success(let codeVerificationResponse):
                        promise(.success(codeVerificationResponse))
                        break
                    }

                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()

    }
    
    func getWelcome(welcomeRequest: WelcomeRequest) -> AnyPublisher<WelcomeResponseEntity, ExternalError> {
        
        
        guard let url = getUrlComponentsToGetWelcome().url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
          
            return AF.request(url,
                                method: .post,
                                parameters: welcomeRequest,
                                encoder: JSONParameterEncoder.default,
                                headers: nil,
                                interceptor: nil,
                                requestModifier: nil)
                  .validate()
                  .publishDecodable(type: WelcomeResponseEntity.self)
                  .mapError({ (never : Never) -> ExternalError in
                      ExternalError.UnknowError(description: never.localizedDescription)
                  })
                  .flatMap({ (dataResponse: DataResponse<WelcomeResponseEntity, AFError>)-> AnyPublisher<WelcomeResponseEntity, ExternalError> in
                      Future<WelcomeResponseEntity, ExternalError> { promise in
                          switch dataResponse.result {
                              
                          case .failure(let afError):
                              promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                              break
                              
                          case .success(let welcomeResponseEntity):
                              promise(.success(welcomeResponseEntity))
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
    
    func getUrlComponentsToGetWelcome() -> URLComponents {
          var urlComponents = URLComponents()
          urlComponents.scheme = FiestonVirtualAPI.scheme
          urlComponents.host = FiestonVirtualAPI.host
          urlComponents.path = FiestonVirtualAPI.path + "/detalle_evento.php"
          return urlComponents
      }

}
