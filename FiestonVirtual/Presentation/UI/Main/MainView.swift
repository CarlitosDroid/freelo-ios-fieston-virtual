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
    
    @State private var selectedTab = 0
    
    @State var isNextActive: Bool = false
    
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
            
            TabView(selection: $selectedTab) {
                HomeView(onCategorySelected: { (index: Int) in
                    self.selectedTab = index
                })
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Menu")
                }.tag(0)
                    
                Text("GALERIA")
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Menu")
                }.tag(1)
                
                PhotosView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Menu")
                }.tag(2)
                
                Text("CHAT")
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Menu")
                }.tag(3)
                
                Text("TRIVIA")
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Menu")
                }.tag(4)
                
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
