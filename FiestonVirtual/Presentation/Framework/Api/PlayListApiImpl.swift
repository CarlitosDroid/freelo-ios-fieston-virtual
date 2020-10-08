
import Foundation
import Combine
import Alamofire
import SwiftyJSON

class PlayListApiImpl : PlayListApi {
    
    func requestSong(
        getRemotePedirCancionRequest: GetRemotePedirCancionRequest
    ) -> AnyPublisher<RequestSongResponseEntity, ExternalError> {
        
        guard let url = requestSongComponents().url
        else {
            let error =
                ExternalError
                .NetworkError(description: "Couldn't create URL")
            return Fail(error: error) .eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: getRemotePedirCancionRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type:
                                RequestSongResponseEntity.self)
            .mapError({(never : Never) -> ExternalError in ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({(dataResponse:
                        DataResponse<RequestSongResponseEntity,AFError>)-> AnyPublisher<RequestSongResponseEntity, ExternalError> in Future<RequestSongResponseEntity, ExternalError> {
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
    
    func getRemotePlaylist(
        getPlaylistRequest: GetPlaylistRequest
    ) -> AnyPublisher<GetPlaylistResponseEntity, ExternalError> {
        
        guard let url = requestSongComponents().url
        else {
            let error =
                ExternalError
                .NetworkError(description: "Couldn't create URL")
            return Fail(error: error) .eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: getPlaylistRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type:
                                GetPlaylistResponseEntity.self)
            .mapError({(never : Never) -> ExternalError in ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({(dataResponse:
                        DataResponse<GetPlaylistResponseEntity,AFError>)-> AnyPublisher<GetPlaylistResponseEntity, ExternalError> in Future<GetPlaylistResponseEntity, ExternalError> {
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

private extension PlayListApiImpl{
   
   struct FiestonVirtualAPI {
       static let scheme = "http"
       static let host = "fiestonvirtual.com"
       static let path = "/app/api"
   }
   
   func requestSongComponents() -> URLComponents {
       var urlComponents = URLComponents()
       urlComponents.scheme = FiestonVirtualAPI.scheme
       urlComponents.host = FiestonVirtualAPI.host
       urlComponents.path = FiestonVirtualAPI.path + "/pedir_cancion.php"
       return urlComponents
   }
   
   func getRemotePlaylistComponents() -> URLComponents {
       var urlComponents = URLComponents()
       urlComponents.scheme = FiestonVirtualAPI.scheme
       urlComponents.host = FiestonVirtualAPI.host
       urlComponents.path = FiestonVirtualAPI.path + "/lista_playlist.php"
       return urlComponents
   }
   
}
