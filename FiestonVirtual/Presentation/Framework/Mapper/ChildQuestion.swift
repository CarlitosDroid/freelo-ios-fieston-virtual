
import Foundation

extension ChildQuestion {
    
    func toTrivia() -> Trivia{
        Trivia(
            questionId: self.idQuestion,
            questionType: self.questionType,
            questionName: self.questionName,
            question: self.question,
            questionScore: self.questionScore,
            questionImageUrl: self.questionImage,
            questionStatus: self.questionStatus,
            questionAlternative: self.questionAlternative.map {
                (childQuestionAlternative : ChildQuestionAlternative) in
                childQuestionAlternative.toAlternative()
                
            }
        )
    }
    
}
