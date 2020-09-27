
import Foundation
import Combine

protocol LikeRepository {
    
    func makeLike(
        makeLikeRequest: MakeLikeRequest
    ) -> AnyPublisher<MakeLikeResponse, ErrorResponse>
    
}
