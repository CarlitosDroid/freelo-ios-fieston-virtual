
import Foundation

struct AnswerTriviaRequest : Encodable {
    let idAlternative: Int
    let idUserSession: Int
}
