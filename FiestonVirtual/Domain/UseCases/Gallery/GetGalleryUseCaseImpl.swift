
import Foundation
import Combine

class GetGalleryUseCaseImpl: GetGalleryUseCase{
    
    private let galleryRepository: GalleryRepository
    private let usersRepository: UsersRepository
    
    init(galleryRepository: GalleryRepository,
         usersRepository: UsersRepository ){
        self.galleryRepository = galleryRepository
        self.usersRepository = usersRepository
    }
    
    func invoke() -> AnyPublisher<[GalleryItem], ErrorResponse> {
        
        switch usersRepository.getLocalUser(){
        
        case .success(let user):
            return galleryRepository.getGallery(
                galleryRequest: GetGalleryRequest(
                    idEvent: user.idEvent,
                    postStatus: 1
                )
            )
        case .failure( let error):
            return Just([]).mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
        }
        
    }
    
}
