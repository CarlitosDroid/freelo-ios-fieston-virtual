
import Foundation

struct GetPlaylistResponseEntity : Decodable {
    
    let message : String
    let data : ChildGetPlaylistResponseEntity
    
}

struct ChildGetPlaylistResponseEntity : Decodable {
    let playlist : [PlayList]
}
