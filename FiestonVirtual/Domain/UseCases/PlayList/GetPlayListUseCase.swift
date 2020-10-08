
import Foundation
import Combine

protocol GetPlayListUseCase {

    func invoke()-> AnyPublisher<[Song], ErrorResponse>
    
}
