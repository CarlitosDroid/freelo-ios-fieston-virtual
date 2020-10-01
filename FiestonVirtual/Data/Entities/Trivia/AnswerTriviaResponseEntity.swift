
import Foundation

struct AnswerTriviaResponseEntity: Decodable {
    let message: String
    let data: ChildAnswerTriviaResponseEntity
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

struct ChildAnswerTriviaResponseEntity: Decodable {
    let userTotalScore: Int
}
