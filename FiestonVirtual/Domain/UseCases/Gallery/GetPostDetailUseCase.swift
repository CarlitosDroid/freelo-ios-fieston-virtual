
import Foundation
import Combine

protocol GetPostDetailUseCase{
    
    func invoke() -> AnyPublisher<GetGalleryDetail, ErrorResponse>
    
}
