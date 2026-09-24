
import Foundation
import Combine

protocol PlaylistRepository {
    
    func requestSong(
        getRemotePedirCancionRequest: GetRemotePedirCancionRequest
    ) -> AnyPublisher<Song, ErrorResponse>
    
    func getRemotePlaylist(
        getPlaylistRequest: GetPlaylistRequest
    ) -> AnyPublisher<[Song], ErrorResponse>
    
}
