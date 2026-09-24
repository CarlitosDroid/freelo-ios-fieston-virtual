
import Foundation
import Combine

class RankingRepositoryImpl : RankingRepository {
    
    private let rankingRemoteDataSource:RankingRemoteDataSource
    
    init(rankingRemoteDataSource:RankingRemoteDataSource){
        self.rankingRemoteDataSource = rankingRemoteDataSource
    }
    
    
    func getRanking(
        getRemoteRankingRequest: GetRemoteRankingRequest
    ) -> AnyPublisher<GetRankingResponse, ErrorResponse> {
        
        return self.rankingRemoteDataSource.getRanking(
            getRemoteRankingRequest: getRemoteRankingRequest
        )
        
    }
    
}
