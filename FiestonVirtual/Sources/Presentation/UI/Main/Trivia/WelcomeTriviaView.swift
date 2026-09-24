
import SwiftUI

struct WelcomeTriviaView: View {
    
    var onClickTriviaButton: () -> Void
    
    var body: some View {
        VStack(spacing: 0, content:{
            
            Text("Trivia")
                .font(.system(size: 40))
                .bold()
                .foregroundColor(Color.aquamarine)
                .padding(.top, 30)
            
            Spacer()
            
            Image("WelcomeTrivia")
            
            Spacer()
            
            Button(action: {
                self.onClickTriviaButton()
            }){
                Text("Jugar")
                    .frame(height: 50)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                    .background(Color.amber_600.cornerRadius(8))
                    .foregroundColor(Color.deep_purple_intense)
            }
            .padding(.bottom, 30)
            
        })
        .padding(15)
        
    }
}

struct WelcomeTriviaView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTriviaView(){
            
        }
    }
}
