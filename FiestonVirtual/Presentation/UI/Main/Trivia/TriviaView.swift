
import SwiftUI
import SwiftUIPager

struct TriviaView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(TriviaViewModel.self)!
    
    @State var trivias = [Trivia]()
    
    @State var page: Int = 0
    
    @State var messageAnswerAlert = ""
    
    @State var showWelcomeTrivia = true
    
    var body: some View {
        
        ZStack{
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            LoadingView(isShowing: self.$viewModel.isLoading) {
                ZStack{
                    
                    if(showWelcomeTrivia){
                        WelcomeTriviaView(){
                            self.page = 0
                            self.viewModel.getTrivia()
                        }
                    }else{
                        Pager(page: self.$page,
                              data: self.trivias,
                              id: \.self) { trivia in
                            TriviaPageView(trivia : trivia){
                                (alternative : Alternative) in
                                self.viewModel.answerTrivia(idAlternative: alternative.alternativeId)
                            }
                        }
                        .alignment(.center)
                        .allowsDragging(false)
                        .horizontal(.leftToRight)
                    }
                    
                }
                
            }
            
        }
        .alert(isPresented: self.$viewModel.showAnswerAlert, content: {
            Alert(
                title: Text("prueba"),
                dismissButton: .cancel(Text("No"), action: {
                    if(self.page == self.trivias.count - 1 ){
                        self.showWelcomeTrivia = true
                    }else{
                        self.page = page + 1
                    }
                })
            )
        })
        .alert(isPresented: self.$viewModel.showErrorMessage, content: {
            Alert(
                title: Text(self.viewModel.errorMessage),
                dismissButton: .default(Text("Aceptar"))
            )
        })
        .onAppear{
            self.showWelcomeTrivia = true
        }
        .onReceive(self.viewModel.$trivia){ trivias in
            if(trivias == nil){ return }
            self.showWelcomeTrivia = false
            self.trivias = trivias!
        }
        .onReceive(self.viewModel.$answerTriviaResponse){ answerTriviaResponse in
            if(answerTriviaResponse == nil){ return }
            self.messageAnswerAlert = answerTriviaResponse!.message
            
        }
        
    }
    
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
