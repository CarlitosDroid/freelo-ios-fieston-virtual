
import Foundation
import Combine

protocol AnswerTriviaUseCase{
    
    func invoke(
        idAlternative: Int
    ) -> AnyPublisher<AnswerTriviaResponse, ErrorResponse>
    
}
