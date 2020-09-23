
import Foundation

struct GalleryItem: Codable,Identifiable{
    let id: Int
    var type: Int
    var file: String
    var status: Int
    var preview: String
}
