
import Foundation
import Combine

protocol RankingRepository {
    
    func getRanking(
        getRemoteRankingRequest: GetRemoteRankingRequest
    ) -> AnyPublisher<GetRankingResponse, ErrorResponse>
    
}
