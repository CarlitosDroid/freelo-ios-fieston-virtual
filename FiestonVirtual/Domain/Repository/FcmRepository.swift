
import Foundation
import Combine

protocol FcmRepository {
 
    func sendToken(sendTokenRequest:SendTokenRequest) -> AnyPublisher<Bool, ErrorResponse>

}
