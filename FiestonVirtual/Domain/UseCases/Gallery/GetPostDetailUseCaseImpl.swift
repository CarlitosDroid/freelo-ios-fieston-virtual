
import Foundation
import Combine

class GetPostDetailUseCaseImpl: GetPostDetailUseCase{
    
    let galleryRepository : GalleryRepository
    
    init(galleryRepository : GalleryRepository){
        self.galleryRepository = galleryRepository
    }
    
    func invoke(postId: Int) -> AnyPublisher<GetGalleryDetail, ErrorResponse> {
        return self.galleryRepository.getGalleryDetail(
            getGalleryDetailRequest: GetGalleryDetailRequest(
                idUserSesion: 1, idPost: postId
            )
        )
    }
    
}
