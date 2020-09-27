
import Foundation
import Combine

protocol MakeLikeUseCase{
    
      func invoke(
           idPost: Int
       ) -> AnyPublisher<MakeLikeResponse, ErrorResponse>
    
}
