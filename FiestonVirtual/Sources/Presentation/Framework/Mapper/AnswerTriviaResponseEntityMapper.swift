
import Foundation

extension AnswerTriviaResponseEntity{
    
    func toDomain() -> AnswerTriviaResponse{
        AnswerTriviaResponse(
            message: self.message,
            userTotalScore: self.data.userTotalScore
        )
    }
}
