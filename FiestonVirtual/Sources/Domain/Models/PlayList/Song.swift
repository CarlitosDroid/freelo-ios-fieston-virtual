
import Foundation

struct Song : Encodable, Identifiable {
    
    let id: Int
    let title: String
    let band: String
    let playListURL: String?
    var requested: Bool

}
