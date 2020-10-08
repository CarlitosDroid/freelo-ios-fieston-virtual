
import Foundation
import Combine

protocol PlayListApi {
    
    func requestSong(
        getRemotePedirCancionRequest: GetRemotePedirCancionRequest
    ) -> AnyPublisher<RequestSongResponseEntity, ExternalError>
    
    func getRemotePlaylist(
        getPlaylistRequest: GetPlaylistRequest
    ) -> AnyPublisher<GetPlaylistResponseEntity, ExternalError>
    
}
