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
    
    var body: some View {
        
        ZStack {
                Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
                    VStack{
                        Image("Fieston")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all, 40)
                        Spacer()
                        
                        TextField("Coloque su código", text: self.$eventCode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .frame(height: 30)
                        
                        VStack{
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
                            self.viewModel.verifyCode(code:"719299")
                        }) {
                            Text("Entrar como invitado")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 350, height: 60, alignment: .center)
                                .background(Color.amber_600)
                                .cornerRadius(15.0)
                        }
                        }
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                .padding(.all, 20)
            
        }.onReceive(self.viewModel.$inSession) { inSession in
            if(inSession) {
                NotificationCenter.default.post(name: NSNotification.Name("loginRootViewNotification"), object: nil)
            }
            
        }.navigationBarHidden(true)
        .alert(isPresented: .constant(self.viewModel.isError), content:{
            Alert(
                title: Text(self.viewModel.errorMessage),
                dismissButton: .default(Text("Aceptar"))
            )
        }).onAppear {
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
