
import Foundation
import Combine

class GetPostDetailUseCaseImpl: GetPostDetailUseCase{
    
    private let galleryRepository : GalleryRepository
    private let usersRepository: UsersRepository
    
    init(
        galleryRepository : GalleryRepository,
        usersRepository: UsersRepository
    ){
        self.galleryRepository = galleryRepository
        self.usersRepository = usersRepository
    }
    
    func invoke(postId: Int) -> AnyPublisher<GetGalleryDetail, ErrorResponse> {
        
        switch self.usersRepository.getLocalUser(){
        case .success(let user):
            return self.galleryRepository.getGalleryDetail(
                getGalleryDetailRequest: GetGalleryDetailRequest(
                    idUserSesion: user.id, idPost: postId
                )
            )
        case .failure( let error):
            return Just(
                GetGalleryDetail(
                    idPost: 0,
                    postType: 0,
                    postFile: "",
                    postTitle: "",
                    postStatus: 0,
                    postLikeCount: 0,
                    postLike: false,
                    userName: "",
                    userImage: ""
                )
            ).mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
        }
        
    }
    
}
