
import Foundation
import Combine

class CommentsRepositoryImpl : CommentsRepository{
    
    let commentsRemoteDataSource : CommentsRemoteDataSource
    
    init(commentsRemoteDataSource : CommentsRemoteDataSource){
        self.commentsRemoteDataSource = commentsRemoteDataSource
    }
    
    func getRemoteComments(
        getCommentsRequest: GetCommentsRequest
    ) -> AnyPublisher<[Comment], ErrorResponse> {
        return self.commentsRemoteDataSource.getComments(getCommentsRequest:getCommentsRequest)
    }
    
    func addComment(
        addCommentRequest : AddCommentRequest
    ) -> AnyPublisher<Comment, ErrorResponse> {
        return self.commentsRemoteDataSource.addComment(
            addCommentRequest : addCommentRequest
        )
    }
    
}
