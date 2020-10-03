
import Foundation

struct Trivia : Encodable,Equatable,Hashable  {
    let questionId: Int
    let questionType: String
    let questionName: String
    let question: String
    let questionScore: Int
    let questionImageUrl: String
    let questionStatus: Int
    let questionAlternative: [Alternative]
}
