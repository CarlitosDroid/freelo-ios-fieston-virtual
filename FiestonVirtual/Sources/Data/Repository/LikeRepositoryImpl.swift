
import Foundation
import Combine

class LikeRepositoryImpl : LikeRepository {
    
    private let likeDataSource : LikeDataSource
    
    init(likeDataSource : LikeDataSource){
        self.likeDataSource = likeDataSource
    }
    
    func makeLike(
        makeLikeRequest: MakeLikeRequest
    ) -> AnyPublisher<MakeLikeResponse, ErrorResponse> {
        self.likeDataSource.makeLike(
            makeLikeRequest : makeLikeRequest
        )
    }
    
}
