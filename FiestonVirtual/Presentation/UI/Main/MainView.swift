//
//  MainView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(WelcomeViewModel.self)!
    
    var body: some View {
        VStack(spacing:0){
            ZStack{
                Image("Fieston")
                HStack{
                    Button(action: {
                    }, label: {
                        Image(systemName: "camera").accentColor(Color.white)
                    })
                    Spacer()
                    Button(action: {
                    }, label: {
                        Image(systemName: "star").accentColor(Color.white)
                    })
                    Button(action: {
                    }, label: {
                        Image(systemName: "star").accentColor(Color.white)
                    })
                }
            }.padding(10).background(Color.deep_purple_500)
            
            TabView {
                Text("HOLA1")
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Menu")
                }
//                PhotosView()
//                    .tabItem {
//                        Image(systemName: "list.dash")
//                        Text("Menu")
//                }
                
            }
            
            WelcomeView(
                welcome:.constant(self.viewModel.welcome),
                showSheet: .constant( self.viewModel.hasWelcome)
            )
        }.onAppear{
            self.viewModel.getWelcome()
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
