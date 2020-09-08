
import Foundation
import Combine

class WelcomeViewModel: ObservableObject {
    
    let getWelcomeUseCase: GetWelcomeUseCase
    
    @Published var eventCode: EventCode?
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private var disposables = Set<AnyCancellable>()
    
    init(getWelcomeUseCase: GetWelcomeUseCase) {
        self.getWelcomeUseCase = getWelcomeUseCase
    }
    
    func verifyCode() {
        self.isLoading = true
        getWelcomeUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                switch completion {
                case .finished:
                    self.isLoading = false
                    break
                case .failure(let errorResponse):
                    self.errorMessage = errorResponse.localizedDescription
                    self.isLoading = false
                    break
                }
            }, receiveValue: { (welcome: Welcome) in
                self.isLoading = false
                print("\(welcome.description)")
            })
            .store(in: &disposables)
    }
}
