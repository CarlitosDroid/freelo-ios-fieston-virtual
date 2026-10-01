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
import SwiftyJSON

class LikeApiImpl: LikeApi {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func makeLike(makeLikeRequest: MakeLikeRequest) -> AnyPublisher<LikeResponse, ExternalError> {
    
        guard let url = makeLikeComponents().url
            else {
                let error =
                ExternalError
                .NetworkError(description: "Couldn't create URL")
                return Fail(error: error) .eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: makeLikeRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
        .validate()
            .publishDecodable(type:
                LikeResponse.self)
            .mapError({(never : Never) -> ExternalError in ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({(dataResponse:
                DataResponse<LikeResponse,AFError>)-> AnyPublisher<LikeResponse, ExternalError> in Future<LikeResponse, ExternalError> {
                    promise in switch dataResponse.result {
                    case .failure(let afError):
                        if let data = dataResponse.data {
                            if let json = try? JSON(data: data) {
                                let message = json["message"].stringValue
                                promise(.failure(ExternalError.NetworkError(description: "\(message)")))
                            }
                        }
                        promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                        break
                        
                    case .success(let likesResponse): promise( .success(likesResponse))
                        break
                    }
                    
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()

    }
    
}

private extension LikeApiImpl {
    
    struct FiestonVirtualAPI {
        static let scheme = APIConfiguration.scheme
        static let host = APIConfiguration.host
        static let path = APIConfiguration.path
    }
    
    func makeLikeComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.port = APIConfiguration.port
        urlComponents.path = FiestonVirtualAPI.path + "/likes.php"
        return urlComponents
    }
    
}
