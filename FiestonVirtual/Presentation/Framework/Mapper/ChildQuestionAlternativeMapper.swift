
import Foundation

extension ChildQuestionAlternative{
    
    func toAlternative() -> Alternative{
        Alternative(
            alternativeId: self.idAlternative,
            alternativeDescription: self.alternativeDescription,
            isAlternativeAnswer: self.alternativeAnswer
        )
    }
    
}
