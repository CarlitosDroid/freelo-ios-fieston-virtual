
import Foundation
import Combine

class GetWelcomeUseCaseImpl:GetWelcomeUseCase  {
    
    let eventRepository:EventCodeRepository
    let usersRepository:UsersRepository
    
    init(eventRepository:EventCodeRepository,
         usersRepository:UsersRepository){
        self.eventRepository=eventRepository
        self.usersRepository=usersRepository
    }
    
    func invoke() -> AnyPublisher<Welcome, ErrorResponse> {
        
        let result = self.usersRepository.getLocalUser()
        switch result {
        case .success(let user):
            return eventRepository.getWelcome(welcomeRequest: WelcomeRequest(idEvent: 3))
        case .failure(let error):
            return Just(Welcome(title:"", description: "", subtitle: "", imageUrl: ""))
                .mapError({ (_) in
                    ErrorResponse(code: 1, title: "", message: error.localizedDescription)
                }).eraseToAnyPublisher()
        }
    }
    
}
