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
        HStack(alignment: .bottom, spacing: 10) {
            Spacer()
            
            VStack(alignment: .trailing, spacing: 6) {
                Text(chatMessage.userName)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(hex: "36FFC4"))

                Text(chatMessage.messageText)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(hex: "071413"))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(hex: "36FFC4"))
                            .shadow(color: Color(hex: "36FFC4").opacity(0.25), radius: 12)
                    )
            }
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
