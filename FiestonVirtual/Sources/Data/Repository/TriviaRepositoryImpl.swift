
import Foundation
import Combine

class TriviaRepositoryImpl : TriviaRepository {
    
    let triviaDataSource : TriviaDataSource
    
    init(triviaDataSource : TriviaDataSource){
        self.triviaDataSource = triviaDataSource
    }
    
    
    func getTrivia(
        triviaRequest: TriviaRequest
    ) -> AnyPublisher<[Trivia], ErrorResponse> {
        self.triviaDataSource.getTrivia(triviaRequest: triviaRequest)
    }
    
    func answerTrivia(
        answerTriviaRequest: AnswerTriviaRequest
    ) -> AnyPublisher<AnswerTriviaResponse, ErrorResponse> {
        self.triviaDataSource.answerTrivia(answerTriviaRequest: answerTriviaRequest)
    }
    
    
}
