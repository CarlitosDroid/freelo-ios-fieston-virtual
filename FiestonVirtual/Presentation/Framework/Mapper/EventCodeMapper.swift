//
//  EventCodeMapper.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

extension CodeVerificationResponse {
    
    func toEventCode() -> EventCode {
        return EventCode(
            idEvent: self.data.event.idEvent,
            idUser: self.data.user.idUser)
    }
    
}
