
import Foundation
import Combine

protocol SendTokenUseCase{
    
    func invoke(token : String) -> AnyPublisher<Bool, ErrorResponse>
    
}
