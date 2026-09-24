//
//  SocketIOResult.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

enum SocketIOResult {
    case ConnectionSuccess(Bool)
    case ConnectionLoading(Bool)
    case ConnectionTimeout(Bool)
    case ConnectionError(Bool)
    case ConnectionDisconnect(Bool)
    
    case ReceiveIncomingMessageSuccess(ChatMessage)
}
