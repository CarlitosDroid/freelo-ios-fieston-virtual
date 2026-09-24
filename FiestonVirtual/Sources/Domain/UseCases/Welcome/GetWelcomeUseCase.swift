
import Foundation
import Combine

protocol GetWelcomeUseCase {
    func invoke() -> AnyPublisher<Welcome, ErrorResponse>
}
