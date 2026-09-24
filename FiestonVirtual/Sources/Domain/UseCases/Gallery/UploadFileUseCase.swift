
import Foundation
import Combine

protocol UploadFileUseCase{
    
    func invoke(
        data: URL,
        postTitle: String
    ) -> AnyPublisher<String, ErrorResponse>
    
}
