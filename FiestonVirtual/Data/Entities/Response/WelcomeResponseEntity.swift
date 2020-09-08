
import Foundation

struct WelcomeResponseEntity :Codable {
    let data: DataResponseEntity
    let message: String
}

struct DataResponseEntity : Codable {
    let event: EventResponseEntity
}

struct EventResponseEntity : Codable {
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
