 
 import Foundation
 import Combine
 
 protocol EventDataSource {
    func getWelcome (welcomeRequest: WelcomeRequest) -> AnyPublisher<Welcome, ErrorResponse>
 }
