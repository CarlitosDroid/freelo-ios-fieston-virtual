
import Foundation
import Combine

protocol AddCommentUseCase {
    
    func invoke(postId: Int, comment: String) -> AnyPublisher<Comment,ErrorResponse>
    
}
