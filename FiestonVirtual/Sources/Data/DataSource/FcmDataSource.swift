
import Foundation
import Combine

protocol FcmDataSource {
 
    func sendToken(sendTokenRequest: SendTokenRequest) -> AnyPublisher<Bool, ErrorResponse>

}
