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
        NavigationView {
            ZStack {
                Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
                LoadingView(isShowing: .constant(viewModel.isLoading)) {
                    ZStack {
                        VStack {
                            Image("Fieston")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.all, 60)
                            Spacer()
                        }
                        
                        VStack {
                            TextField("Coloque su código", text: self.$eventCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                            
                            NavigationLink(
                                destination: MainView(),
                                isActive: self.$viewModel.inSession,
                                label: { Button(action: {
                                    self.viewModel.verifyCode(code: self.eventCode)
                                }) {
                                    Text("Entrar")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50, alignment: .center)
                                        .background(Color.aqua.cornerRadius(8))
                                        .foregroundColor(Color.white)
                                    }
                            })
                        }.padding(.all, 15)
                    }
                }
            }
        }
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
