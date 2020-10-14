//
//  SocketIOViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON

class SocketIOViewModel : ObservableObject {
    
    let socketManager = DependencyProvider().assembler.resolver.resolve(SocketManager.self)
    let socket: SocketIOClient?
    let usersRepository: UsersRepository
    private var isUserConnected = false
    
    @Published var socketIOResult: SocketIOResult?
    
    init(usersRepository: UsersRepository) {
        self.socket = socketManager?.defaultSocket
        self.usersRepository = usersRepository
    }
    
    func startListeners() {
        self.socket?.on(clientEvent: .error, callback: { (data: [Any], ack: SocketAckEmitter) in
            
            print(data)
            self.socketIOResult = SocketIOResult.ConnectionError(true)
            
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
            self.socketIOResult = SocketIOResult.ConnectionSuccess(true)
            
        })
        self.socket?.on(clientEvent: .disconnect, callback: { (data: [Any], ack: SocketAckEmitter) in
            self.isUserConnected = false
            
            self.socketIOResult = SocketIOResult.ConnectionDisconnect(true)
            
        })
        
        self.socket?.on(MESSAGE_EVENT, callback: { (data: [Any], ack: SocketAckEmitter) in
            
            let json = JSON(data[0])
            
            print(json)
            
            let idUserMessage = json[ID_USER_KEY].intValue
            let messageText = json[MESSAGE_KEY].stringValue
            let userImage = json[USER_IMAGE_KEY].stringValue
            let userName = json[USERNAME_KEY].stringValue
            
            // TODO - Web service must return idMessage too
            let chatMessage =
                ChatMessage(
                    idMessage: UUID().uuidString,
                    messageText: messageText,
                    userName: userName,
                    userId: idUserMessage,
                    userImage: userImage,
                    viewType: ChatMessageViewType.INCOMING(value: 1)
                )
            self.socketIOResult = SocketIOResult.ReceiveIncomingMessageSuccess(chatMessage)
            
        
        })
        
        self.socket?.connect()
    }
    
    func stopListeners() {
        self.socket?.disconnect()
        self.socket?.off(clientEvent: .connect)
        self.socket?.off(clientEvent: .disconnect)
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
