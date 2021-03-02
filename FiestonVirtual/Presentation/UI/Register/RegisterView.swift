//
//  RegisterView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 1/03/21.
//  Copyright © 2021 Spydevs. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    
    var viewMode: CodeVerificationViewModel
    
    @Binding var showRegister: Bool
    
    @State private var email: String = ""
    @State private var name: String = ""
    
    var body: some View {
        
        VStack {
            EmptyView()
        }.sheet(isPresented: $showRegister, content: {
            
            VStack(spacing: 10) {
                Spacer()
                
                Image("Fieston").resizable().frame(width: 230, height:60)
                
                TextField("Nombre", text: self.$email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 30)
                
                SecureField("Contraseña", text: self.$name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 30)
                
                Button(action: {
                    self.viewMode.verifyCode(code:"719299")
                }) {
                    Text("Registrar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50, alignment: .center)
                        .background(Color.amber_600)
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding(10)
            .background(Color.deep_purple_intense)
            
        })
        
    }
}
