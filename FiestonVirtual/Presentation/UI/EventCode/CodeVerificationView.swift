//
//  CodeVerificationView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct CodeVerificationView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(CodeVerificationViewModel.self)!
    
    @State private var nombre: String = ""
    
    @State private var eventCode: String = ""
    
    @State var showOneLevelIn = false
    
    @State private var showingAlert = false
    
    @State private var showRegister = false
    
    var body: some View {
        
        ZStack {
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Fieston")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
            }.padding(50)
            
            VStack(alignment: .center, spacing: 10) {
                
                TextField("Nombre", text: self.$nombre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(height: 30)
                
                SecureField("Contraseña", text: self.$eventCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(height: 30)
                
                Button(action: {
                    self.viewModel.verifyCode(code: self.eventCode)
                }) {
                    Text("Iniciar sesión")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50, alignment: .center)
                        .background(Color.aquamarine)
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                }
                
                Button(action: {
                    showRegister = true
                }) {
                    Text("Registrar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50, alignment: .center)
                        .background(Color.amber_600)
                        .cornerRadius(8)
                }
            }
            .padding(10)
            
            RegisterView(viewMode: self.viewModel, showRegister: $showRegister)
            
        }
        .onReceive(self.viewModel.$inSession) { inSession in
            if(inSession) {
                NotificationCenter.default.post(name: NSNotification.Name("loginRootViewNotification"), object: nil)
            }
            
        }
        .onReceive(self.viewModel.$isError, perform: { isError in
            if(isError) {
                self.showingAlert = true
            }
        })
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert, content: {
            
            return Alert(
                title: Text(self.viewModel.errorMessage),
                dismissButton: .default(Text("Aceptar"))
            )
            
        })
        .onAppear {
            self.viewModel.verifySession()
            print("ContentView appeared!")
        }.onDisappear {
            print("ContentView disappeared!")
            
        }
        
    }
    
}

struct CodeVerificationView_Previews: PreviewProvider {
    
    static var previews: some View {
        CodeVerificationView()
    }
}
