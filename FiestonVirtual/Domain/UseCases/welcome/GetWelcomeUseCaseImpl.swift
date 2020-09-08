
import Foundation
import Combine

class GetWelcomeUseCaseImpl:GetWelcomeUseCase  {
    
    let eventRepository:EventRepository
    
    init(eventRepository:EventRepository){
        self.eventRepository=eventRepository
    }
    
    func invoke() -> AnyPublisher<Welcome, ErrorResponse> {
        return self.eventRepository.getWelcome(welcomeRequest: WelcomeRequest(idEvent: 1))
    }
    
}
