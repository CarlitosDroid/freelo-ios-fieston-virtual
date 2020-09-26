
import Foundation
import Combine

protocol CommentsRepository{
    
    func getRemoteComments(
        getCommentsRequest: GetCommentsRequest
    ) -> AnyPublisher<[Comment], ErrorResponse>
    
    func addComment(
        addCommentRequest : AddCommentRequest
    ) -> AnyPublisher<Comment,ErrorResponse>
    
}
