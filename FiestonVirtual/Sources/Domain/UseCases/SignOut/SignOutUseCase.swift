
import Foundation
import Combine

protocol SignOutUseCase {
    
    func invoke() -> AnyPublisher<Bool, ErrorResponse>

}
