
import Foundation

struct SendTokenResponse : Decodable {
    let message : String
    let data : ChildSendTokenResponse
}

struct ChildSendTokenResponse : Decodable{
    let rpta : Bool
}
