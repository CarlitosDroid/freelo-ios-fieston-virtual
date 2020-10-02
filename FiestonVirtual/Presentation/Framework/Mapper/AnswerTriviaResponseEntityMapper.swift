
import Foundation

extension AnswerTriviaResponseEntity{
    
    func toDomain() -> AnswerTriviaResponse{
        AnswerTriviaResponse(userTotalScore: self.data.userTotalScore)
    }
}
