
import Foundation
import Combine

protocol LikeDataSource {
    
    func makeLike(
        makeLikeRequest: MakeLikeRequest
    ) -> AnyPublisher<MakeLikeResponse, ErrorResponse>
    
}
