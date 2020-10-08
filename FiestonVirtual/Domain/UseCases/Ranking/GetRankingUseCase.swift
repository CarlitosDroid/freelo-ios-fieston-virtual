
import Foundation
import Combine

protocol GetRankingUseCase{
    
    func invoke() -> AnyPublisher<GetRankingResponse, ErrorResponse>

}
