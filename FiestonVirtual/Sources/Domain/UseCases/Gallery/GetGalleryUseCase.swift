
import Foundation
import Combine

protocol GetGalleryUseCase{
    
    func invoke()->AnyPublisher<[GalleryItem],ErrorResponse>
    
}
