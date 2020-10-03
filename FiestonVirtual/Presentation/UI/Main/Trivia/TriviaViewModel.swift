
import Foundation
import Combine

class TriviaViewModel : ObservableObject {
    
    private let getTriviaUseCase: GetTriviaUseCase
    private let answerTriviaUseCase: AnswerTriviaUseCase
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var showErrorMessage = false
    
    
    @Published var trivia : [Trivia]?
    @Published var answerTriviaResponse : AnswerTriviaResponse?
    
    
    @Published var showAnswerAlertMessage : AnswerTriviaResponse?
    
    
    
    @Published var showAnswerAlert = false
    
    private var disposables = Set<AnyCancellable>()
    
    
    
    init(getTriviaUseCase: GetTriviaUseCase,
         answerTriviaUseCase: AnswerTriviaUseCase) {
        self.getTriviaUseCase = getTriviaUseCase
        self.answerTriviaUseCase = answerTriviaUseCase
    }
    
    func getTrivia(){
        self.isLoading = true
        getTriviaUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.showErrorMessage = true
                    self.errorMessage = errorResponse.message
                    break
                }
            }, receiveValue: { (trivia: [Trivia]) in
                self.trivia = trivia
            })
            .store(in: &disposables)
    }
    
    func answerTrivia(idAlternative: Int) {
        self.isLoading = true
        answerTriviaUseCase.invoke(idAlternative: idAlternative)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    self.showAnswerAlert = true
                    break
                case .failure(let errorResponse):
                    self.showErrorMessage = true
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (answerTriviaResponse: AnswerTriviaResponse) in
                self.answerTriviaResponse = answerTriviaResponse
            })
            .store(in: &disposables)
        
    }
    
}
