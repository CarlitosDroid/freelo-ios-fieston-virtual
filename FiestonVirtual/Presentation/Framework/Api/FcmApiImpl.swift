
import Foundation
import Combine
import Alamofire
import SwiftyJSON

class FcmApiImpl : FcmApi{
    
    func sendToken(sendTokenRequest: SendTokenRequest) -> AnyPublisher<SendTokenResponse, ExternalError> {
        
        guard let url = sendTokenComponents().url
        else {
            let error =
                ExternalError
                .NetworkError(description: "Couldn't create URL")
            return Fail(error: error) .eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: sendTokenRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type:SendTokenResponse.self)
            .mapError({(never : Never) -> ExternalError in ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({(dataResponse:
                        DataResponse<SendTokenResponse,AFError>)-> AnyPublisher<SendTokenResponse, ExternalError> in Future<SendTokenResponse, ExternalError> {
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
                                
                            case .success(let sendTokenResponse): promise( .success(sendTokenResponse))
                                break
                            }
                        
                        }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
        
    }
    
}

private extension FcmApiImpl{
   
   struct FiestonVirtualAPI {
       static let scheme = "http"
       static let host = "fiestonvirtual.com"
       static let path = "/app/api"
   }
   
   func sendTokenComponents() -> URLComponents {
       var urlComponents = URLComponents()
       urlComponents.scheme = FiestonVirtualAPI.scheme
       urlComponents.host = FiestonVirtualAPI.host
       urlComponents.path = FiestonVirtualAPI.path + "/registrar_tokens.php"
       return urlComponents
   }
   
}
