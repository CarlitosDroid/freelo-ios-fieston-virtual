//
//  ChatMessagesApiImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/13/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

class ChatMessagesApiImpl: ChatMessagesApi {
    
    func getMessages(
        messageRequest: MessageRequest
    ) -> AnyPublisher<MessagesResponse, ExternalError> {
        guard let url = makeChatMessagesComponents().url
        else {
            let error =
                ExternalError
                .NetworkError(description: "Couldn't create URL")
            return Fail(error: error) .eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: messageRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: MessagesResponse.self)
            .mapError({(never : Never) -> ExternalError in ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({(dataResponse:
                        DataResponse<MessagesResponse,AFError>)-> AnyPublisher<MessagesResponse, ExternalError> in Future<MessagesResponse, ExternalError> {
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
                                
                            case .success(let messagesResponse):
                                promise(.success(messagesResponse))
                                break
                            }
                        
                        }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
        
    }
    
}

private extension ChatMessagesApiImpl{
   
   struct FiestonVirtualAPI {
       static let scheme = "http"
       static let host = "fiestonvirtual.com"
       static let path = "/app/api"
   }
   
   func makeChatMessagesComponents() -> URLComponents {
       var urlComponents = URLComponents()
       urlComponents.scheme = FiestonVirtualAPI.scheme
       urlComponents.host = FiestonVirtualAPI.host
       urlComponents.path = FiestonVirtualAPI.path + "/mensajes_chat.php"
       return urlComponents
   }
   

}
