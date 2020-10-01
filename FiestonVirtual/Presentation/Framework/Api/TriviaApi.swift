
import Foundation
import Combine

protocol TriviaApi {
    
    func getTrivia(
        triviaRequest: TriviaRequest
    ) -> AnyPublisher<TriviaResponse, ExternalError>
    
    func answerTrivia(
        answerTriviaRequest: AnswerTriviaRequest
    ) -> AnyPublisher<AnswerTriviaResponseEntity, ExternalError>
    
}
