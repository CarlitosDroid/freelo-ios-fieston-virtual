
import Foundation
import Combine

protocol GetCommentsUseCase{
    
    func invoke(
        getCommentsRequest : GetCommentsRequest
    )-> AnyPublisher<[Comment],ErrorResponse>
    
}
