
import Foundation

extension WelcomeResponseEntity {
    
    func toWelcome() -> Welcome {
        let event = self.data.event
        let imageUrl = event.eventLogo.isEmpty ? event.eventImagePrize : event.eventLogo

        return Welcome(
            title: event.eventName,
            description: event.eventWelcomeText,
            subtitle: event.eventPrize,
            imageUrl: imageUrl
        )
    }
    
}
