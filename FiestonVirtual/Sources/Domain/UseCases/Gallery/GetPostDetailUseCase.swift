
import Foundation
import Combine

protocol GetPostDetailUseCase{
    
    func invoke(postId: Int) -> AnyPublisher<GetGalleryDetail, ErrorResponse>
    
}
