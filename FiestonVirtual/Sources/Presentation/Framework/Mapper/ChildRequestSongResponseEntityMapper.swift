
import Foundation

extension ChildRequestSongResponseEntity {
    
    func toSong() -> Song{
        return Song(
            id: self.idPlaylist,
            title: self.playlistSong,
            band: self.playlistBand,
            playListURL: self.playListURL,
            requested: self.playlistStatus
        )
    }
    
}
