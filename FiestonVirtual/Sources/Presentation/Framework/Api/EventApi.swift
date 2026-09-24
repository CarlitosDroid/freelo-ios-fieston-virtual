
import Foundation
import Combine

protocol EventApi {
    func validateCode(userInvitationCode: Int) -> AnyPublisher<CodeVerificationResponseEntity, ExternalError>
}
