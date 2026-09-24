
import Foundation

extension WelcomeResponseEntity {
    
    func toWelcome() -> Welcome {
        return Welcome(
            title: self.data.event.eventName,
            description: self.data.event.eventWelcomeText,
            subtitle: self.data.event.eventPrize,
            imageUrl: self.data.event.eventImagePrize
        )
    }
    
}

