
import Foundation
import Combine

class PlaylistRepositoryImpl : PlaylistRepository {
    
    private let playlistDataSource : PlaylistDataSource
    
    init(playlistDataSource : PlaylistDataSource){
        self.playlistDataSource = playlistDataSource
    }
    
    func requestSong(
        getRemotePedirCancionRequest : GetRemotePedirCancionRequest
    ) -> AnyPublisher<Song, ErrorResponse> {
        self.playlistDataSource.requestSong(
            getRemotePedirCancionRequest: getRemotePedirCancionRequest
        )
    }
    
    func getRemotePlaylist(
        getPlaylistRequest : GetPlaylistRequest
    ) -> AnyPublisher<[Song], ErrorResponse> {
        return self.playlistDataSource.getRemotePlaylist(getPlaylistRequest: getPlaylistRequest)
    }
    
}
