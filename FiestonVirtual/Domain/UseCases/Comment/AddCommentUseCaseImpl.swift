
import Foundation
import Combine

class AddCommentUseCaseImpl : AddCommentUseCase {
    
    private let commentsRepository:CommentsRepository
    private let usersRepository: UsersRepository
    
    init(
        commentsRepository:CommentsRepository,
        usersRepository: UsersRepository
    ){
        self.commentsRepository = commentsRepository
        self.usersRepository = usersRepository
    }
    
    func invoke(postId: Int, comment: String) -> AnyPublisher<Comment, ErrorResponse> {
        
        switch usersRepository.getLocalUser() {
        
        case .success( let user):
            return self.commentsRepository.addComment(
                addCommentRequest: AddCommentRequest(
                    idPost: postId,
                    idUserComment: user.id,
                    comment: comment
                )
            )
            
        case .failure(let error):
            return Just(
                Comment(id: 0, text: "", avatar: "", userName: "")
            )
            .mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
        
    }
    
    
}
