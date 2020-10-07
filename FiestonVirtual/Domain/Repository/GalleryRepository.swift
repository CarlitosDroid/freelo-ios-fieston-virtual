
import Foundation
import Combine

protocol GalleryRepository {
    
    func getGallery(
        galleryRequest: GetGalleryRequest
    ) -> AnyPublisher<[GalleryItem], ErrorResponse>
    
    func getGalleryDetail(
        getGalleryDetailRequest: GetGalleryDetailRequest
    ) -> AnyPublisher<GetGalleryDetail, ErrorResponse>
    
    func uploadFile(
        data: URL,
        idUser: Int,
        idEvent: Int,
        postTitle: String
    ) -> AnyPublisher<String, ErrorResponse>
    
}
