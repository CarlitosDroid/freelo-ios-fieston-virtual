
import Foundation

struct WelcomeResponseEntity : Decodable {
    let data: WelcomeDataResponseEntity
    let message: String
}

struct WelcomeDataResponseEntity : Decodable {
    let event: WelcomeEventResponseEntity
}

struct WelcomeEventResponseEntity : Decodable {
    let eventHost: String
    let eventImagePrize: String
    let eventLogo: String
    let eventName: String
    let eventPrize: String
    let eventStartDate: String
    let eventStatus: Int
    let eventWelcomeText: String
    let idEvent: Int
}
