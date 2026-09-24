
import Foundation
import Combine

class GetPlayListUseCaseImpl : GetPlaylistUseCase {
    
    private let playlistRepository : PlaylistRepository
    private let usersRepository : UsersRepository
    
    init(
        playlistRepository : PlaylistRepository,
        usersRepository: UsersRepository
    ){
        self.playlistRepository = playlistRepository
        self.usersRepository = usersRepository
    }
    
    func invoke()-> AnyPublisher<[Song], ErrorResponse>{
        
        switch self.usersRepository.getLocalUser(){
        
        case .success( let user):
            return self.playlistRepository.getRemotePlaylist(
                getPlaylistRequest: GetPlaylistRequest(
                    idEvent: user.idEvent,
                    search: ""
                )
            )
            
        case .failure(let error):
            return Just(
                [Song]()
            )
            .mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
        
    }
    
}
