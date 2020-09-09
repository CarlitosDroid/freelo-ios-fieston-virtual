//
//  EventCodeApiImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class EventCodeApiImpl: EventCodeApi {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func validateCode(userInvitationCode: Int) -> AnyPublisher<CodeVerificationResponseEntity, ExternalError> {
        return requestVerificationCode(with: makeCodeVerificationComponents(), userInvitationCode: userInvitationCode)
    }
    
    func getWelcome(welcomeRequest: WelcomeRequest) -> AnyPublisher<WelcomeResponseEntity, ExternalError>{
        return requestGetWelcome(with: getUrlComponentsToGetWelcome(), welcomeRequest: welcomeRequest)
        
    }
    
    private func requestVerificationCode<T>(
        with components: URLComponents,
        userInvitationCode: Int
    ) -> AnyPublisher<T, ExternalError> where T: Decodable {
        guard let url = components.url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlRequest = makeVerificationPostUrlRequest(url: url, userInvitationCode: userInvitationCode)
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { (error: Error) -> ExternalError in
                ExternalError.NetworkError(description: error.localizedDescription)
        }
        .flatMap({ (output: URLSession.DataTaskPublisher.Output) in
            return decode(output.data)
        })
            .eraseToAnyPublisher()
    }
    
    private func makeVerificationPostUrlRequest(url: URL, userInvitationCode: Int) -> URLRequest {
        // Prepare URL Request Object
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let body = [
            "userInvitationCode" : "\(userInvitationCode)"
        ]
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        return urlRequest
    }
    
    private func requestGetWelcome<T>(
        with components: URLComponents,
        welcomeRequest: WelcomeRequest
    ) -> AnyPublisher<T, ExternalError> where T: Decodable {
        guard let url = components.url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlRequest = getUrlToGetWelcome(url: url, welcomeRequest: welcomeRequest)
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { (error: Error) -> ExternalError in
                ExternalError.NetworkError(description: error.localizedDescription)
        }
        .flatMap({ (output: URLSession.DataTaskPublisher.Output) in
            return decode(output.data)
        })
            .eraseToAnyPublisher()
    }
    
    private func getUrlToGetWelcome(url: URL, welcomeRequest: WelcomeRequest) -> URLRequest {
        // Prepare URL Request Object
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let body = [
            "idEvent" : "\(welcomeRequest.idEvent)"
        ]
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        return urlRequest
    }
    
}

private extension EventCodeApiImpl {
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
        static let key = "<your key>"
    }
    
    func makeCodeVerificationComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/consulta_codigo.php"
        
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
    
    func getUrlComponentsToGetWelcome() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/detalle_evento.php"
        return urlComponents
    }
    
}
