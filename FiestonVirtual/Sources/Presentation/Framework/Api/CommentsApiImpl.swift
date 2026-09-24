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

class CommentsApiImpl: CommentsApi {
    
    func getComments(getCommentsRequest: GetCommentsRequest) -> AnyPublisher<GetCommentResponse, ExternalError> {
        
        guard let url = getCommentsComponents().url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: getCommentsRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: GetCommentResponse.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<GetCommentResponse, AFError>)-> AnyPublisher<GetCommentResponse, ExternalError> in
                Future<GetCommentResponse, ExternalError> { promise in
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
    
    func addComment(
        addCommentRequest : AddCommentRequest
    ) -> AnyPublisher<AddCommentResponse, ExternalError> {
        
        guard let url = addCommentComponents().url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: addCommentRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: AddCommentResponse.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<AddCommentResponse, AFError>)-> AnyPublisher<AddCommentResponse, ExternalError> in
                Future<AddCommentResponse, ExternalError> { promise in
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

private extension CommentsApiImpl {
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
        static let key = "<your key>"
    }
    
    func getCommentsComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/comentarios.php"
        return urlComponents
    }
    
    func addCommentComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/agregar_comentarios.php"
        return urlComponents
    }
}




