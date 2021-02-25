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
    
    @State private var eventCode: String = ""
    
    @State var showOneLevelIn = false
    
    @State private var showingAlert = false
    @State private var errorType = 0
    
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
                
                TextField("Coloque su código", text: self.$eventCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(height: 30)
                
                Button(action: {
                    self.viewModel.verifyCode(code: self.eventCode)
                }) {
                    Text("Entrar")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50, alignment: .center)
                        .background(Color.aquamarine)
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                    
                }
                Button(action: {
                    errorType = 1
                    showingAlert = true
                }) {
                    Text("Obtener Código")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150, alignment: .center)
                        .background(Color.amber_600)
                        .cornerRadius(8.0)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(10)
            
        }
        .onReceive(self.viewModel.$inSession) { inSession in
            if(inSession) {
                NotificationCenter.default.post(name: NSNotification.Name("loginRootViewNotification"), object: nil)
            }
            
        }
        .onReceive(self.viewModel.$isError, perform: { isError in
            if(isError) {
                errorType = 0
                self.showingAlert = true
            }
        })
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert, content: {
            
            if(errorType == 0) {
                return Alert(
                    title: Text(self.viewModel.errorMessage),
                    dismissButton: .default(Text("Aceptar"))
                )
            } else {
                return Alert(
                    title: Text("Obtener Código"),
                    message: Text("Para obtener información de como obtener un código de invitación, visite nuesrta página web"),
                    primaryButton: .cancel(Text("Cancel")),
                    secondaryButton: .default(Text("Visitar"), action: {
                        if let url = URL(string: "http://www.fiestonvirtual.com/codigos-app.php") {
                            UIApplication.shared.open(url)
                        }
                    })
                )
            }
            
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
