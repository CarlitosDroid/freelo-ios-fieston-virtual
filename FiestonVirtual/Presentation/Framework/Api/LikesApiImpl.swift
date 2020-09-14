//
//  LikesApiImpl.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class LikesApiImpl: LikesApi {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getLikesData(getRemoteLikesRequest: GetRemoteLikesRequest) -> AnyPublisher<LikesResponse, ExternalError> {
        
        let getRemoteLikesRequest =
        GetRemoteLikesRequest(idUserSesion: 0, idPost: 0)
        
        
        guard let url = makeLikesComponents().url
            else {
                let error =
                ExternalError
                .NetworkError(description: "Couldn't create URL")
                return Fail(error: error) .eraseToAnyPublisher()
        }
        
        return AF.request(url, method: . post,
                          parameters: getRemoteLikesRequest, encoder: JSONParameterEncoder.default,headers: nil,interceptor: nil, requestModifier: nil)
        .validate()
            .publishDecodable(type:
                LikesResponse.self)
            .mapError({(never : Never) -> ExternalError in ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({(dataResponse:
                DataResponse<LikesResponse,AFError>)-> AnyPublisher<LikesResponse, ExternalError> in Future<LikesResponse, ExternalError> {
                    promise in switch dataResponse.result {
                    case .failure(let afError): promise( .failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                        break
                        
                    case .success(let likesResponse): promise( .success(likesResponse))
                        break
                    }
                    
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()

    }
    
}

private extension LikesApiImpl {
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
        static let key = "<your key>"
    }
    
    func makeLikesComponents() ->URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme =
        FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path
        + "/likes.php"
        return urlComponents
    }
}
