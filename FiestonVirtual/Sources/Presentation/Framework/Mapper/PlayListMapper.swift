
import Foundation

extension PlayList {
    
    func toSong() -> Song {
        Song(
            id: self.idPlaylist,
            title: self.playlistSong,
            band: self.playlistBand,
            playListURL: self.playListURL,
            requested: self.playlistStatus
        )
    }
    
}
