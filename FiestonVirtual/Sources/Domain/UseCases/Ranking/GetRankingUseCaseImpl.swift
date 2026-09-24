
import Foundation
import Combine

class GetRankingUseCaseImpl : GetRankingUseCase{
    
    private let rankingRepository: RankingRepository
    private let usersRepository: UsersRepository
    
    init(
        rankingRepository: RankingRepository,
        usersRepository: UsersRepository
    ){
        self.rankingRepository = rankingRepository
        self.usersRepository = usersRepository
    }
    
    func invoke() -> AnyPublisher<GetRankingResponse, ErrorResponse> {
        switch self.usersRepository.getLocalUser(){
        case .success( let user):
            return self.rankingRepository.getRanking(
                getRemoteRankingRequest: GetRemoteRankingRequest(
                    idUser: user.id,
                    idEvent: user.idEvent
                )
            )
            
        case .failure(let error):
            return Just(
                GetRankingResponse(
                    ranking: [Ranking](), userTotalScore: ""
                )
            )
            .mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
    }
    
}
