
import Foundation
import Combine

class GetCommentsUseCaseImpl : GetCommentsUseCase{
    
    private let commentsRepository:CommentsRepository
    
    init(commentsRepository:CommentsRepository){
        self.commentsRepository=commentsRepository
    }
    
    func invoke(
        getCommentsRequest : GetCommentsRequest
    ) -> AnyPublisher<[Comment], ErrorResponse> {
        return self.commentsRepository.getRemoteComments(getCommentsRequest:getCommentsRequest)
    }
    
}
