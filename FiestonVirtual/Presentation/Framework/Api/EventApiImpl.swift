
import Foundation

class EventApiImpl: EventApi {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func validateCode(userInvitationCode: Int) -> AnyPublisher<CodeVerificationResponseEntity, ExternalError> {
        return request(with: makeCodeVerificationComponents(userInvitationCode: String(userInvitationCode)))
    }
    
    private func request<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, ExternalError> where T: Decodable {
        guard let url = components.url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { (error: Error) -> ExternalError in
                ExternalError.NetworkError(description: error.localizedDescription)
            }
            .flatMap({ (output: URLSession.DataTaskPublisher.Output) in
                return decode(output.data)
            })
            .eraseToAnyPublisher()
    }
    
}

private extension EventCodeApiImpl {
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
        static let key = "<your key>"
    }
    
    func makeCodeVerificationComponents(userInvitationCode: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = FiestonVirtualAPI.scheme
        components.host = FiestonVirtualAPI.host
        components.path = FiestonVirtualAPI.path + "/consulta_codigo.php"
        
        components.queryItems = [
            URLQueryItem(name: "userInvitationCode", value: userInvitationCode)
        ]
        
        return components
    }

}
