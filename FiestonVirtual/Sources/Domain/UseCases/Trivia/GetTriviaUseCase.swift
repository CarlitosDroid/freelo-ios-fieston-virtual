
import Foundation
import Combine

protocol GetTriviaUseCase{
    
    func invoke() -> AnyPublisher<[Trivia], ErrorResponse>
    
}
