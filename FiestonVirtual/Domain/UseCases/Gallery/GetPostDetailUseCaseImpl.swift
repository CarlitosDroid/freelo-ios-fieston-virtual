
import Foundation
import Combine

class GetPostDetailUseCaseImpl: GetPostDetailUseCase{
    
    let galleryRepository : GalleryRepository
    
    init(galleryRepository : GalleryRepository){
        self.galleryRepository = galleryRepository
    }
    
    func invoke() -> AnyPublisher<GetGalleryDetail, ErrorResponse> {
        return self.galleryRepository.getGalleryDetail(
            getGalleryDetailRequest: GetGalleryDetailRequest(
                idUserSesion: 1, idPost: 1
            )
        )
    }
    
}
