
import Foundation

struct SignOutResponse: Codable {
    let message: String
    let data:SignOutDataResponse
}

struct SignOutDataResponse: Codable {
    let rpta: Bool
}
