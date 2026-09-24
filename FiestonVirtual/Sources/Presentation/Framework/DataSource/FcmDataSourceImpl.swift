
import Foundation
import Combine

class FcmDataSourceImpl : FcmDataSource{
    
    private let fcmApi : FcmApi
    
    init(fcmApi : FcmApi) {
        self.fcmApi = fcmApi
    }
    
    func sendToken(sendTokenRequest: SendTokenRequest) -> AnyPublisher<Bool, ErrorResponse> {
        return self.fcmApi.sendToken(sendTokenRequest: sendTokenRequest)
            .mapError{ (externalError:ExternalError) -> ErrorResponse in
                switch externalError {
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
            }
            .map{ (sendTokenResponse : SendTokenResponse) -> Bool in
                return sendTokenResponse.data.rpta
            }.eraseToAnyPublisher()
    }
    
    
}
