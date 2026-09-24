
import Foundation

extension ChildRequestSongResponseEntity {
    
    func toSong() -> Song{
        return Song(
            id: self.idPlaylist,
            title: self.playlistSong,
            band: self.playlistBand,
            requested: self.playlistStatus
        )
    }
    
}
