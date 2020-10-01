
import Foundation

struct Alternative : Encodable {
    let alternativeId: Int
    let alternativeDescription: String
    let isAlternativeAnswer: Bool
    let isSelected: Bool = false
}
