
import Foundation

struct Alternative : Encodable,Identifiable,Equatable,Hashable {
    let id : UUID = UUID()
    let alternativeId: Int
    let alternativeDescription: String
    let isAlternativeAnswer: Bool
    let isSelected: Bool = false
}
