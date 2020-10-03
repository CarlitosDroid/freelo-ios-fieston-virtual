 
 import Foundation
 import Combine
 import Alamofire
 
 class TriviaApiImpl : TriviaApi{
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getTrivia(triviaRequest: TriviaRequest) -> AnyPublisher<TriviaResponse, ExternalError> {
        
        guard let url = getTriviaComponents().url
        else {
            let error =
                ExternalError
                .NetworkError(description: "Couldn't create URL")
            return Fail(error: error) .eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: triviaRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type:
                                TriviaResponse.self)
            .mapError({(never : Never) -> ExternalError in ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({(dataResponse:
                        DataResponse<TriviaResponse,AFError>)-> AnyPublisher<TriviaResponse, ExternalError> in Future<TriviaResponse, ExternalError> {
                            promise in switch dataResponse.result {
                            case .failure(let afError): promise( .failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                                break
                                
                            case .success(let likesResponse): promise( .success(likesResponse))
                                break
                            }
                        
                        }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
        
    }
    
    func answerTrivia(answerTriviaRequest: AnswerTriviaRequest) -> AnyPublisher<AnswerTriviaResponseEntity, ExternalError>  {
        
        guard let url = answerTriviaComponents().url
        else {
            let error =
                ExternalError
                .NetworkError(description: "Couldn't create URL")
            return Fail(error: error) .eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: answerTriviaRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: AnswerTriviaResponseEntity.self)
            .mapError(
                {(never : Never) -> ExternalError in ExternalError.UnknowError(description: never.localizedDescription)}
            )
            .flatMap({(dataResponse:
                        DataResponse<AnswerTriviaResponseEntity,AFError>)-> AnyPublisher<AnswerTriviaResponseEntity, ExternalError> in Future<AnswerTriviaResponseEntity, ExternalError> {
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
 
 private extension TriviaApiImpl{
    
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
    }
    
    func getTriviaComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/trivias.php"
        return urlComponents
    }
    
    func answerTriviaComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/respuesta_trivia.php"
        return urlComponents
    }
    
 }
