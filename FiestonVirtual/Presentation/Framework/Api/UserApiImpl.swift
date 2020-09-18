//
//  UserApiImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class UserApiImpl: UserApi {
    
    func getUserData(idUser: Int) -> AnyPublisher<UserResponse, ExternalError> {
      
        let getRemoteUserRequest = GetRemoteUserRequest(idUser: idUser)
        
        // TODO: - use headers if necessary or create a function for this snippet
        //        let headers: HTTPHeaders = [
        //                "Authorization": "Basic \(getBase64Credentials())",
        //                "Content-Type": "application/x-www-form-urlencoded"
        //        ]
        
        
        guard let url = makeUserComponents().url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: getRemoteUserRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: UserResponse.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<UserResponse, AFError>)-> AnyPublisher<UserResponse, ExternalError> in
                Future<UserResponse, ExternalError> { promise in
                    switch dataResponse.result {
                        
                    case .failure(let afError):
                        promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                        break
                        
                    case .success(let userResponse):
                        promise(.success(userResponse))
                        break
                    }
                    
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
        
    }
    
    func signOut(signOutRequest: SignOutRequest) -> AnyPublisher<SignOutResponse, ExternalError> {
        
        guard let url = signOutUrlComponents().url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: signOutRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: SignOutResponse.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<SignOutResponse, AFError>)-> AnyPublisher<SignOutResponse, ExternalError> in
                Future<SignOutResponse, ExternalError> { promise in
                    switch dataResponse.result {
                        
                    case .failure(let afError):
                        promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                        break
                        
                    case .success(let signOutResponse):
                        promise(.success(signOutResponse))
                        break
                    }
                    
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
        
    }
    
}

private extension UserApiImpl {
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
        static let key = "<your key>"
    }
    
    func makeUserComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/detalle_usuario.php"
        return urlComponents
    }
    
    func signOutUrlComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/logout.php"
        return urlComponents
    }
    
}
