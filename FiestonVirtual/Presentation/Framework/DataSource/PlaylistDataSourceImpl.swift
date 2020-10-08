
import Foundation
import Combine

class PlaylistDataSourceImpl : PlaylistDataSource {
    
    private let playListApi : PlayListApi
    
    init(playListApi : PlayListApi){
        self.playListApi = playListApi
    }
    
    func requestSong(
        getRemotePedirCancionRequest: GetRemotePedirCancionRequest
    ) -> AnyPublisher<Song, ErrorResponse> {
        self.playListApi.requestSong(
            getRemotePedirCancionRequest : getRemotePedirCancionRequest
        )
        .mapError{ (externalError:ExternalError) -> ErrorResponse in
            switch externalError {
            case .NetworkError(let description):
                return ErrorResponse(title: "Error en la red", message: description)
            case .Parsing(let description):
                return ErrorResponse(title: "Error al parsear", message: description)
            case .UnknowError(let description):
                return ErrorResponse(title: "Error Desconocido", message: description)
            }
        }
        .map{ (requestSongResponseEntity : RequestSongResponseEntity) -> Song in
            return requestSongResponseEntity.data.toSong()
        }.eraseToAnyPublisher()
    }
    
    func getRemotePlaylist(
        getPlaylistRequest: GetPlaylistRequest
    ) -> AnyPublisher<[Song], ErrorResponse> {
        self.playListApi.getRemotePlaylist(getPlaylistRequest: getPlaylistRequest)
            .mapError{ (externalError:ExternalError) -> ErrorResponse in
                switch externalError {
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
            }
            .map{ (getPlaylistResponseEntity : GetPlaylistResponseEntity) -> [Song] in
                return getPlaylistResponseEntity.data.playlist.map{ playlist in
                    playlist.toSong()
                }
                
            }.eraseToAnyPublisher()
    }
    
    
}
