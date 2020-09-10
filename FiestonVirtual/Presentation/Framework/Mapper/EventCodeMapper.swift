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
            mensajito: self.message,
            idEvent: self.data?.event?.idEvent ?? 100,
            idUser: self.data?.user?.idUser ?? 200)
    }
    
}
