
import Foundation
import Combine

class EventRepositoryImpl : EventRepository{
    
    let eventDataSource: EventDataSource
    
    init(eventDataSource: EventDataSource){
        self.eventDataSource=eventDataSource
    }
    
    func getWelcome(welcomeRequest: WelcomeRequest) -> AnyPublisher<Welcome, ErrorResponse> {
        return self.eventDataSource.getWelcome(welcomeRequest: welcomeRequest)
    }
    
}
