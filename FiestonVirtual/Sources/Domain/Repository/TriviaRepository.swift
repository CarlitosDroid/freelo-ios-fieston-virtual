
import Foundation
import Combine

protocol TriviaRepository {
    
    func getTrivia(triviaRequest: TriviaRequest) -> AnyPublisher<[Trivia], ErrorResponse>
    
    func answerTrivia(
        answerTriviaRequest: AnswerTriviaRequest
    ) -> AnyPublisher<AnswerTriviaResponse, ErrorResponse>
    
}
