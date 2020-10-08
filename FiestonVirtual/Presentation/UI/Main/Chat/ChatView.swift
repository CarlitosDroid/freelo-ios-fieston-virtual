//
//  ChatView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var socketIOViewModel = DependencyProvider().assembler.resolver.resolve(SocketIOViewModel.self)!
    
    var body: some View {
        VStack {
            
        Text(socketIOViewModel.statusMessage)
            .onAppear {
                self.socketIOViewModel.startListeners()
            }.onDisappear {
                self.socketIOViewModel.stopListeners()
            }
            
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
