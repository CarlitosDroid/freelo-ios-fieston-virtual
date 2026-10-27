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
        HStack(alignment: .bottom, spacing: 10) {
            avatar

            VStack(alignment: .leading, spacing: 6) {
                Text(chatMessage.userName)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(hex: "D8D8DC"))

                Text(chatMessage.messageText)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(hex: "E6E3E8"))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(hex: "252A2C").opacity(0.96))
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.white.opacity(0.14), lineWidth: 1)
                            )
                    )
            }

            Spacer()
        }
    }

    private var avatar: some View {
        KFImage(URL(string: chatMessage.userImage))
            .resizable()
            .placeholder {
                Circle()
                    .fill(Color(hex: "403D49"))
                    .overlay(Text(initials).foregroundColor(.white))
            }
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white.opacity(0.25), lineWidth: 1))
    }

    private var initials: String {
        String(chatMessage.userName.prefix(2)).uppercased()
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        IncomingChatMessage(chatMessage: ChatMessage(idMessage: "1", messageText: "", userName: "", userId: 0, userImage: "", viewType: .INCOMING(value: 1)))
    }
}
