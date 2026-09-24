
import Foundation

struct EventApi {
    func getEventWelcome(welcomeRequest: WelcomeRequest) -> AnyPublisher<WelcomeResponseEntity,ExternalError>
}
