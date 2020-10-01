
import Foundation
import Combine

class AnswerTriviaUseCaseImpl : AnswerTriviaUseCase{
    
    private let triviaRepository: TriviaRepository
    
    private let usersRepository: UsersRepository
    
    init(triviaRepository: TriviaRepository,
         usersRepository: UsersRepository){
        self.triviaRepository = triviaRepository
        self.usersRepository = usersRepository
    }
    
    func invoke(idAlternative: Int) -> AnyPublisher<AnswerTriviaResponse, ErrorResponse> {
        switch self.usersRepository.getLocalUser(){
        case .success( let user):
            return self.triviaRepository.answerTrivia(
                answerTriviaRequest: AnswerTriviaRequest(
                    idAlternative : idAlternative ,
                    idUserSession: user.id
                )
            )            
            
        case .failure(let error):
            return Just(
                AnswerTriviaResponse(userTotalScore: 0)
            )
            .mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
    }
    
}
