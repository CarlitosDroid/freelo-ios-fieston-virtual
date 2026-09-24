
import Foundation
import Combine

class UploadFileUseCaseImpl : UploadFileUseCase{
    
    private let galleryRepository : GalleryRepository
    private let usersRepository : UsersRepository
    
    init(
        galleryRepository : GalleryRepository,
        usersRepository : UsersRepository
    ){
        self.galleryRepository = galleryRepository
        self.usersRepository = usersRepository
    }
    
    func invoke(
        data: URL,
        postTitle: String
    ) -> AnyPublisher<String, ErrorResponse> {
        
        switch self.usersRepository.getLocalUser(){
        case .success(let user):
            return self.galleryRepository.uploadFile(
                data:data,
                idUser: user.id,
                idEvent: user.idEvent,
                postTitle: postTitle
            )
        case .failure( let error):
            return Just(
                ""
            ).mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
        }
        
    }
    
}
