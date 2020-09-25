
import Foundation
import Combine

class GalleryRepositoryImpl : GalleryRepository{
    
    let galleryDataSource : GalleryDataSource
    
    init(galleryDataSource :GalleryDataSource){
        self.galleryDataSource = galleryDataSource
    }
    
    func getGallery(
        galleryRequest: GetGalleryRequest
    ) -> AnyPublisher<[GalleryItem], ErrorResponse> {
        return self.galleryDataSource.getGallery(galleryRequest: galleryRequest)
    }
    
    func getGalleryDetail(
        getGalleryDetailRequest: GetGalleryDetailRequest
    ) -> AnyPublisher<GetGalleryDetail, ErrorResponse> {
        return self.galleryDataSource.getGalleryDetail(getGalleryDetailRequest: getGalleryDetailRequest)
    }
    
}
