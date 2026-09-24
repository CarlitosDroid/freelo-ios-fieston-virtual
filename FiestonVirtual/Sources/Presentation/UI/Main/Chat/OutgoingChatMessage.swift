//
//  OutgoingChatMessage.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct OutgoingChatMessage: View {
    
    var chatMessage: ChatMessage
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 15) {
            Spacer()
            
            VStack(alignment: HorizontalAlignment.trailing, spacing: 2) {
                Text(chatMessage.userName)
                    .bold()
                Text(chatMessage.messageText)
            }
            .padding(10)
            .background(Color.green)
            .cornerRadius(10)
            
            KFImage(URL(string: chatMessage.userImage))
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
        }
    }
}

struct OutgoingChatMessage_Previews: PreviewProvider {
    static var previews: some View {
        OutgoingChatMessage(chatMessage: ChatMessage(
                                idMessage: "1",
                                messageText: "",
                                userName: "",
                                userId: 0,
                                userImage: "",
                                viewType: .INCOMING(value: 1)))
    }
}
