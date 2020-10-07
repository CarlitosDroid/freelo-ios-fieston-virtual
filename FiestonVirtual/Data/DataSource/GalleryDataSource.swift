
import Foundation
import Combine

protocol GalleryDataSource {
    
    func getGallery(
        galleryRequest: GetGalleryRequest
    )-> AnyPublisher<[GalleryItem], ErrorResponse>
    
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
