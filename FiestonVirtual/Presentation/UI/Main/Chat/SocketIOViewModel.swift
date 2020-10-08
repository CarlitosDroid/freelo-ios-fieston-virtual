//
//  SocketIOViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOViewModel : ObservableObject {
    
    let socketManager = DependencyProvider().assembler.resolver.resolve(SocketManager.self)
    let socket: SocketIOClient?
    let usersRepository: UsersRepository
    private var isUserConnected = false
    
    @Published var statusMessage = ""
    
    init(usersRepository: UsersRepository) {
        self.socket = socketManager?.defaultSocket
        self.usersRepository = usersRepository
    }
    
    func startListeners() {
        self.socket?.on(clientEvent: .error, callback: { (data: [Any], ack: SocketAckEmitter) in
            self.statusMessage = "Error"
        })
        self.socket?.on(clientEvent: .connect, callback: { (data: [Any], ack: SocketAckEmitter) in
            
            if (!self.isUserConnected) {
                
                switch self.usersRepository.getLocalUser() {
                case .success(let user):
                    self.socket?.emit(JOIN_EVENT, user.id)
                    break
                case .failure( _):
                    break
                }
                self.isUserConnected = true
            }
            self.statusMessage = "Connected"
            
        })
        self.socket?.on(clientEvent: .disconnect, callback: { (data: [Any], ack: SocketAckEmitter) in
            self.isUserConnected = false
            self.statusMessage = "Disconnected"
        })
        
        self.socket?.on(MESSAGE_EVENT, callback: { (data: [Any], ack: SocketAckEmitter) in
            print(data)
            
        })
        
        self.socket?.connect()
    }
    
    func stopListeners() {
        self.socket?.disconnect()
        self.socket?.off(clientEvent: .connect)
        self.socket?.off(clientEvent: .disconnect)
        self.socket?.off(MESSAGE_EVENT)
    }
    
    func sendMessage(message: String) {
        self.socket?.emit(MESSAGE_EVENT, message)
    }
    
}

let MESSAGE_EVENT = "message"
let JOIN_EVENT = "join"
let MESSAGE_KEY = "messageText"
let USERNAME_KEY = "userName"
let ID_USER_KEY = "idUserMessage"
let USER_IMAGE_KEY = "userImage"
