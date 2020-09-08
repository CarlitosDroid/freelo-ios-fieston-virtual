
import Foundation
import Combine

protocol EventRepository {
    
    func getWelcome (welcomeRequest: WelcomeRequest) -> AnyPublisher<Welcome, ErrorResponse>
    
}
