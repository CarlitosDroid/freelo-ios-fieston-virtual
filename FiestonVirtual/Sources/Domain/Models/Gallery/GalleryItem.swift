
import Foundation

struct GalleryItem: Codable, Identifiable, Hashable{
    let id: Int
    var type: Int
    var file: String
    var status: Int
    var preview: String
}

enum GalleryItemType : Int {
    case photo = 1
    case video = 2
}
