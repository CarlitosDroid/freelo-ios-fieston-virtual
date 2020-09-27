
import Foundation
import Combine

class MakeLikeUseCaseImpl : MakeLikeUseCase {
    
    private let usersRepository : UsersRepository
    private let likeRepository : LikeRepository
    
    init(usersRepository : UsersRepository,
         likeRepository : LikeRepository){
        self.usersRepository = usersRepository
        self.likeRepository = likeRepository
    }
    
    func invoke(idPost: Int) -> AnyPublisher<MakeLikeResponse, ErrorResponse> {
        
        switch self.usersRepository.getLocalUser() {
        
        case .success( let user):
            return self.likeRepository.makeLike(
                makeLikeRequest: MakeLikeRequest(
                    idUserSesion: user.id,
                    idPost: idPost
                )
            )
            
        case .failure(let error):
            return Just(
                MakeLikeResponse(likes: 0)
            )
            .mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
        
    }
    
}
