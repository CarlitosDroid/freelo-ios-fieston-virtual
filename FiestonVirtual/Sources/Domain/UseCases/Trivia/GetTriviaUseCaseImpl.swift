
import Foundation
import Combine

class GetTriviaUseCaseImpl : GetTriviaUseCase{
    
    private let triviaRepository: TriviaRepository
    
    private let usersRepository: UsersRepository
    
    init(triviaRepository: TriviaRepository,
         usersRepository: UsersRepository){
        self.triviaRepository = triviaRepository
        self.usersRepository = usersRepository
    }
    
    func invoke() -> AnyPublisher<[Trivia], ErrorResponse> {
        
        switch self.usersRepository.getLocalUser(){
        
        case .success( let user):
            return self.triviaRepository.getTrivia(
                triviaRequest: TriviaRequest(
                    idEvent: user.idEvent,
                    questionStatus: 1,
                    idUserSession: user.id
                )
            )
            
        case .failure(let error):
            return Just(
                []
            )
            .mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
    }
    
    
}
