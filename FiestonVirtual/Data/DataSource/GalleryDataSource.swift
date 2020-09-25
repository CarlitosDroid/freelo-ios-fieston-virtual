
import Foundation
import Combine

protocol GalleryDataSource {
    
    func getGallery(
        galleryRequest: GetGalleryRequest
    )-> AnyPublisher<[GalleryItem], ErrorResponse>
    
}
