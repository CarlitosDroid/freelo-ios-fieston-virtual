//
//  UserApiImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class UserApiImpl: UserApi {
    
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getUserData(idUser: Int) -> AnyPublisher<UserResponseEntity, ExternalError> {
        return requestUser(with: makeUserComponents(), idUser: idUser)
    }
    
    private func requestUser<T>(
        with components: URLComponents,
        idUser: Int
    ) -> AnyPublisher<T, ExternalError> where T: Decodable {
        guard let url = components.url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlRequest = makeUserPostUrlRequest(url: url, idUser: idUser)
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { (error: Error) -> ExternalError in
                ExternalError.NetworkError(description: error.localizedDescription)
        }
        .flatMap({ (output: URLSession.DataTaskPublisher.Output) in
            return decode(output.data)
        })
            .eraseToAnyPublisher()
    }
    
    private func makeUserPostUrlRequest(url: URL, idUser: Int) -> URLRequest {
        // Prepare URL Request Object
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let body = [
            "idUser" : "\(idUser)"
        ]
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        return urlRequest
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
        
        /** We could use this code in order to make form-data
         let queryStringParam  =  [
         "page":"1",
         "size":"5",
         "sortBy":"profile_locality"
         ]
         
         let queryItems = queryStringParam.map  { URLQueryItem(name: $0.key, value: $0.value) }
         */
        
        return urlComponents
    }
    
    
    
    
}
