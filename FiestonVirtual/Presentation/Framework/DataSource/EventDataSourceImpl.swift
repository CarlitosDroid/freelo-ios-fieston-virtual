
import Foundation
import Combine
//TODO update
struct EventDataSourceImpl{
    
    var eventCodeApi  : EventCodeApi
    
    init(eventCodeApi: EventCodeApi) {
        self.eventCodeApi = eventCodeApi
    }
    /*
     func getWelcome(welcomeRequest: WelcomeRequest) -> AnyPublisher<Welcome, ErrorResponse> {
     return eventCodeApi.validateCode(1,1 ; Int)
     .mapError { (externalError: ExternalError) -> ErrorResponse in
     switch externalError {
     case .NetworkError(let description):
     return ErrorResponse(title: "Error en la red", message: description)
     case .Parsing(let description):
     return ErrorResponse(title: "Error al parsear", message: description)
     case .UnknowError(let description):
     return ErrorResponse(title: "Error Desconocido", message: description)
     }
     }
     .map { (welcomeResponseEntity: WelcomeResponseEntity) -> Welcome in
     return welcomeResponseEntity.toWelcome()
     }.eraseToAnyPublisher()
     }
     */
    
}
