
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
            ).flatMap { (answerTriviaResponse: AnswerTriviaResponse) ->
                AnyPublisher<AnswerTriviaResponse, ErrorResponse> in
                self.usersRepository.updateLocalTotalScoreOfUser(totalScore: answerTriviaResponse.userTotalScore)
                return Just(answerTriviaResponse)
                    .mapError({ (_) in
                        ErrorResponse(code: 1, title: "", message: "")
                    }).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
            
        case .failure(let error):
            return Just(
                AnswerTriviaResponse(
                    message: "",
                    userTotalScore: 0
                )
            )
            .mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
    }
    
}
