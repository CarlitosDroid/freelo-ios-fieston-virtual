
import Foundation
import Combine

class TriviaViewModel : ObservableObject {
    
    private let getTriviaUseCase: GetTriviaUseCase
    private let answerTriviaUseCase: AnswerTriviaUseCase
    
    init(getTriviaUseCase: GetTriviaUseCase,
         answerTriviaUseCase: AnswerTriviaUseCase) {
        self.getTriviaUseCase = getTriviaUseCase
        self.answerTriviaUseCase = answerTriviaUseCase
    }
    
}
