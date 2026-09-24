
import Foundation
import Combine

protocol GetPlaylistUseCase {
    
    func invoke()-> AnyPublisher<[Song], ErrorResponse>
    
}
