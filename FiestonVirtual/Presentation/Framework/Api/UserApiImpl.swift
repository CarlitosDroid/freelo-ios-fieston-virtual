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
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getUserData(idUser: Int) -> AnyPublisher<UserResponseEntity, ExternalError> {
      
        let getRemoteUserRequest = GetRemoteUserRequest(idUser: idUser)
        
        // TODO: - use headers if necessary or create a function for this snippet
        //        let headers = [
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
            .publishDecodable(type: UserResponseEntity.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<UserResponseEntity, AFError>)-> AnyPublisher<UserResponseEntity, ExternalError> in
                Future<UserResponseEntity, ExternalError> { promise in
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
    
}
