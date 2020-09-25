
import Foundation
import Combine

class GalleryDataSourceImpl : GalleryDataSource{
    
    let galleryApi : GalleryApi
    
    init(galleryApi : GalleryApi) {
        self.galleryApi = galleryApi
    }
    
    func getGallery(
        galleryRequest: GetGalleryRequest
    ) -> AnyPublisher<[GalleryItem], ErrorResponse> {
        return galleryApi.getGallery(galleryRequest: galleryRequest)
            .mapError{ (externalError:ExternalError) -> ErrorResponse in
                switch externalError {
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
            }
            .map{ (getGalleryResponse : GetGalleryResponse)->[GalleryItem] in
                return  getGalleryResponse.data.posts.map{(item:ChildGetGalleryPostsResponse) in item.toDomain()
                }
            }.eraseToAnyPublisher()
    }
    
}
