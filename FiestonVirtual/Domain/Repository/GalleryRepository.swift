
import Foundation
import Combine

protocol GalleryRepository {
    
    func getGallery(
        galleryRequest: GetGalleryRequest
    ) -> AnyPublisher<[GalleryItem], ErrorResponse>
    
    func getGalleryDetail(
        getGalleryDetailRequest: GetGalleryDetailRequest
    ) -> AnyPublisher<GetGalleryDetail, ErrorResponse>
    
}
