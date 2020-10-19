
import Foundation
import Combine

protocol FcmApi {
    
    func sendToken(
        sendTokenRequest: SendTokenRequest
    ) -> AnyPublisher<SendTokenResponse, ExternalError>
    
}
