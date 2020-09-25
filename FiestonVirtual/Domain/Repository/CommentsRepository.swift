
import Foundation
import Combine

protocol CommentsRepository{
    
     func getRemoteComments(
        getCommentsRequest: GetCommentsRequest
      ) -> AnyPublisher<[Comment], ErrorResponse>
    
}
