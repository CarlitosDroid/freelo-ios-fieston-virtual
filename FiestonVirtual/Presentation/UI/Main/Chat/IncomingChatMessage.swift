//
//  ChatMessageView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct IncomingChatMessage: View {
    
    var chatMessage: ChatMessage
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 15) {
            KFImage(URL(string: chatMessage.userImage))
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            VStack(alignment: HorizontalAlignment.leading, spacing: 2) {
                Text(chatMessage.userName)
                    .bold()
                Text(chatMessage.messageText)
            }
            .padding(10)
            .foregroundColor(Color.black)
            .background(Color.white)
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        IncomingChatMessage(chatMessage: ChatMessage(idMessage: "1", messageText: "", userName: "", userId: 0, userImage: "", viewType: .INCOMING(value: 1)))
    }
}
