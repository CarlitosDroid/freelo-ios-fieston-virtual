
import SwiftUI

struct TriviaPageView: View {
    
    @State var trivia : Trivia
    
    var onAlternativeSelected: (_ alternative : Alternative) -> Void
    
    var body: some View {
        VStack(spacing: 0, content: {
            
            Text(self.trivia.questionName)
                .font(.system(size: 26))
                .bold()
                .foregroundColor(Color.amber_600)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.top, 15)

            Text(self.trivia.question)
                .font(.system(size: 26))
                .bold()
                .foregroundColor(Color.aqua)
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.top, 15)
                .padding(.bottom, 15)

            ForEach(self.trivia.questionAlternative){ alternative in
                Button(action: {
                    self.onAlternativeSelected(alternative)
                }){
                    Text(alternative.alternativeDescription)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50, alignment: .center)
                        .background(Color.white.cornerRadius(8))
                        .foregroundColor(Color.deep_purple_intense)
                }
            }
            .padding(.top, 14)
            
            Spacer()
            
        })
        .padding(15)        
        
    }
}

struct TriviaPageView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaPageView(
            trivia: Trivia(
                questionId: 155,
                questionType: "Adivinanza",
                questionName: "204",
                question: "¿Donde originaron los juegos olímpicos?",
                questionScore: 5,
                questionImageUrl: "",
                questionStatus: 1,
                questionAlternative: [
                    Alternative(
                        alternativeId: 1,
                        alternativeDescription: "Perú",
                        isAlternativeAnswer: false),
                    Alternative(
                        alternativeId: 2,
                        alternativeDescription: "Ecuador",
                        isAlternativeAnswer: false),
                    Alternative(
                        alternativeId: 3,
                        alternativeDescription: "Grecia",
                        isAlternativeAnswer: false)
                ]
            )
        ){_ in 
            
        }
    }
}
