
import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    let signOutUseCase: SignOutUseCase
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var isClosedSession = false
    
    private var disposables = Set<AnyCancellable>()
    
    init(signOutUseCase: SignOutUseCase) {
        self.signOutUseCase = signOutUseCase
    }
    
    func signOut() {
        self.isLoading = true
        self.signOutUseCase.invoke()
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
            }, receiveValue: { (isClosedSession: Bool) in
                self.isClosedSession = isClosedSession
            })
            .store(in: &disposables)
    }
    
}
