//
//  RankingApiImpl.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class RankingApiImpl: RankingApi {
    
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getRankingData(idUser: Int, idEvent: Int ) -> AnyPublisher<RankingResponseEntity, ExternalError> {
        let getRemoteRankingRequest = GetRemoteRankingRequest(idUser: idUser, idEvent: idEvent)
        
        guard let url = makeRankinglComponents().url else{
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
                return Fail(error: error).eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: getRemoteRankingRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: RankingResponseEntity.self)
            .mapError({ (never : Never) -> ExternalError in ExternalError.UnknowError(description:
                never.localizedDescription)
            })
            .flatMap({(dataResponse: DataResponse<RankingResponseEntity,AFError>)-> AnyPublisher<RankingResponseEntity, ExternalError> in
                Future<RankingResponseEntity, ExternalError> { promise in
                    switch dataResponse.result {
                        
                    case .failure(let afError):
                        promise(.failure(ExternalError.NetworkError(description:
                            "\(afError.localizedDescription)")))
                        break
                        
                    case .success(let rankingResponseEntity):
                        promise(.success(rankingResponseEntity))
                        break
                    }
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
    }
}


private extension RankingApiImpl {
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
        static let key = "<your key>"
    }
    
    func makeRankinglComponents() -> URLComponents {
    var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.scheme = FiestonVirtualAPI.host
        urlComponents.scheme = FiestonVirtualAPI.path + "/ranking.php"
        return urlComponents

    }
}
