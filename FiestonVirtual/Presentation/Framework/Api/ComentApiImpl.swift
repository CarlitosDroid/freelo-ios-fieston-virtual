//
//  ComentApiImpl.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/11/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class ComentApiImpl: ComentApi {
    
    func getComentApi(idUser: Int) -> AnyPublisher<GetComentResponse, ExternalError> {
        
        let getComentRequest = GetComentRequest(idPost: 0)
            
            guard let url = makeGetComentComponents().url else {
                let error = ExternalError.NetworkError(description: "Couldn't create URL")
                return Fail(error: error).eraseToAnyPublisher()
            }
            
            return AF.request(url,
                              method: .post,
                              parameters: getComentRequest,
                              encoder: JSONParameterEncoder.default,
                              headers: nil,
                              interceptor: nil,
                              requestModifier: nil)
                .validate()
                .publishDecodable(type: GetComentResponse.self)
                .mapError({ (never : Never) -> ExternalError in
                    ExternalError.UnknowError(description: never.localizedDescription)
                })
                .flatMap({ (dataResponse: DataResponse<GetComentResponse, AFError>)-> AnyPublisher<GetComentResponse, ExternalError> in
                    Future<GetComentResponse, ExternalError> { promise in
                        switch dataResponse.result {
                            
                        case .failure(let afError):
                            promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                            break
                            
                        case .success(let getComentResponse):
                            promise(.success(getComentResponse))
                            break
                        }
                        
                    }.eraseToAnyPublisher()
                }).eraseToAnyPublisher()
            
        }

    func addComent() -> AnyPublisher<AddComentResponse, ExternalError> {
         
               let addComentRequest = AddComentRequest(idPost: 0, idUserComment: 2, comment: "e")
                   
                   guard let url = makeGetComentComponents().url else {
                       let error = ExternalError.NetworkError(description: "Couldn't create URL")
                       return Fail(error: error).eraseToAnyPublisher()
                   }
                   
                   return AF.request(url,
                                     method: .post,
                                     parameters: addComentRequest,
                                     encoder: JSONParameterEncoder.default,
                                     headers: nil,
                                     interceptor: nil,
                                     requestModifier: nil)
                       .validate()
                       .publishDecodable(type: AddComentResponse.self)
                       .mapError({ (never : Never) -> ExternalError in
                           ExternalError.UnknowError(description: never.localizedDescription)
                       })
                       .flatMap({ (dataResponse: DataResponse<AddComentResponse, AFError>)-> AnyPublisher<AddComentResponse, ExternalError> in
                           Future<AddComentResponse, ExternalError> { promise in
                               switch dataResponse.result {
                                   
                               case .failure(let afError):
                                   promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                                   break
                                   
                               case .success(let addComentResponse):
                                   promise(.success(addComentResponse))
                                   break
                               }
                               
                           }.eraseToAnyPublisher()
                       }).eraseToAnyPublisher()
                   
    }
    
}

private extension ComentApiImpl {
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
        static let key = "<your key>"
    }
    
    func makeGetComentComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/comentarios.php"
        return urlComponents
    }
    
    func makeAddComentComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/agregar_comentarios.php"
        return urlComponents
    }
}




