
import Foundation
import Combine

class RequestSongUseCaseImpl : RequestSongUseCase {
    
    private let playlistRepository : PlaylistRepository
    private let usersRepository : UsersRepository
    
    init(
        playlistRepository : PlaylistRepository,
        usersRepository: UsersRepository
    ){
        self.playlistRepository = playlistRepository
        self.usersRepository = usersRepository
    }
    
    func invoke(idPlaylist: Int) -> AnyPublisher<Song, ErrorResponse> {
        switch self.usersRepository.getLocalUser(){
        
        case .success( let user):
            return self.playlistRepository.requestSong(
                getRemotePedirCancionRequest: GetRemotePedirCancionRequest(
                    idUser: user.id,
                    idPlaylist: idPlaylist
                )
            )
            
        case .failure(let error):
            return Just(
                Song(id: 0, title: "", band: "", requested: false)
            )
            .mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
    }
    
}
