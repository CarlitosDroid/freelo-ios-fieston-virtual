
import Foundation
import Combine

class CommentsRemoteDataSourceImpl : CommentsRemoteDataSource {
    
    let commentsApi : CommentsApi
    
    init(commentsApi : CommentsApi){
        self.commentsApi = commentsApi
    }
    
    func getComments(
        getCommentsRequest: GetCommentsRequest
    ) -> AnyPublisher<[Comment], ErrorResponse> {
        return self.commentsApi.getComments(getCommentsRequest: getCommentsRequest)
            .mapError{ (externalError:ExternalError) -> ErrorResponse in
                switch externalError {
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
            }
            .map{ (getCommentResponse : GetCommentResponse) -> [Comment] in
                return  getCommentResponse.data.comments.map{(childGetCommentsResponse:ChildGetCommentsResponse) in
                    childGetCommentsResponse.toComment()
                }
            }.eraseToAnyPublisher()
    }
    
}
