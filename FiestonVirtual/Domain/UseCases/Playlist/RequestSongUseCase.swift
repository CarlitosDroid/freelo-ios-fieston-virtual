
import Foundation
import Combine

protocol RequestSongUseCase {
    
    func invoke(idPlaylist: Int)-> AnyPublisher<Song, ErrorResponse>
    
}
