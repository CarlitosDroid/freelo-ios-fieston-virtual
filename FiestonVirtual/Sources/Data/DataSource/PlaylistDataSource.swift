
import Foundation
import Combine

protocol PlaylistDataSource {
    
    func requestSong(
        getRemotePedirCancionRequest: GetRemotePedirCancionRequest
    ) -> AnyPublisher<Song, ErrorResponse>
    
    func getRemotePlaylist(
        getPlaylistRequest: GetPlaylistRequest
    ) -> AnyPublisher<[Song], ErrorResponse>
    
}
