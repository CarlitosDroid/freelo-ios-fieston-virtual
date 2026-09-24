
import Foundation
import Combine

class RankingViewModel: ObservableObject {
    
    let getRankingUseCase: GetRankingUseCase
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var showErrorMessage = false
    
    @Published var getRankingResponse : GetRankingResponse?
    @Published var userTotalScore : String?
    
    private var disposables = Set<AnyCancellable>()
    
    init(getRankingUseCase: GetRankingUseCase ) {
        self.getRankingUseCase = getRankingUseCase
    }
    
    func getRanking() {
        self.isLoading = true
        self.getRankingUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (getRankingResponse: GetRankingResponse) in
                self.getRankingResponse = getRankingResponse
            })
            .store(in: &disposables)
    }
    
    
}
