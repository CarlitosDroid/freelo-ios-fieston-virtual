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
            
            Button(action: {
                self.viewModel.verifyCode(code: self.eventCode)
            }) {
                Text("Entrar")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50, alignment: .center)
                    .background(Color.aqua.cornerRadius(8))
                    .foregroundColor(Color.white)
            }.padding(.all, 20)
            
            LoadingView(isShowing: self.$viewModel.isLoading) {
                ZStack{
                    VStack {
                        Image("Fieston")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all, 40)
                        Spacer()
                    }
                    
                    VStack {
                        TextField("Coloque su código", text: self.$eventCode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        Spacer()
                            .frame(height: 100)
                    }
                }.padding(.all, 20)
            }
            
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
