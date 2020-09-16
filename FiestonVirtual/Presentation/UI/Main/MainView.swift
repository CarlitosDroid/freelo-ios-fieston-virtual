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
    
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing:0){
                    //                    ZStack{
                    //                        Image("Fieston")
                    //                        HStack{
                    //                            Button(action: {
                    //                            }, label: {
                    //                                Image(systemName: "camera").accentColor(Color.white)
                    //                            })
                    //                            Spacer()
                    //                            Button(action: {
                    //                            }, label: {
                    //                                Image(systemName: "star").accentColor(Color.white)
                    //                            })
                    //                            Button(action: {
                    //                            }, label: {
                    //                                Image(systemName: "star").accentColor(Color.white)
                    //                            })
                    //                        }
                    //                    }.padding(10).background(Color.deep_purple_500)
                    
                    TabView(selection: $selectedTab) {
                        HomeView { (index: Int) in
                            if(index == 8) {
                                self.isActive = true
                            } else {
                                self.selectedTab = index
                            }
                            
                        }
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
                        }.tag(3).foregroundColor(Color.red)
                        
                        Text("TRIVIA")
                            .tabItem {
                                Image(systemName: "list.dash")
                                Text("Menu")
                        }.tag(4)
                        
                    }
                    
                    WelcomeView(
                        welcome:.constant(self.viewModel.welcome),
                        showSheet: self.$viewModel.hasWelcome
                    )
                    
                }
                .onAppear{
                    if(!self.isActive) {
                        self.viewModel.getWelcome()
                    }
                }
                
                NavigationLink(destination: PlayListView(), isActive: $isActive){
                    EmptyView()
                }
                //                .navigationBarBackButtonHidden(true)
                //                .navigationBarTitle("Hola")
                //                .navigationBarHidden(true)
                
            }.navigationBarTitle("Fieston Virtual", displayMode: .inline)
                .navigationBarItems(
                    leading: Image(systemName: "camera")
                        .foregroundColor(Color.deep_purple_500),
                    
                    trailing: HStack {
                        Image(systemName: "star")
                            .foregroundColor(Color.deep_purple_500)
                        
                        Button("Salir") {
                            
                            // TODO - CALL THIS METHOD ONCE DATABASE IS EMPTY AFTER LOG OUT
                            //NotificationCenter.default.post(name: NSNotification.Name("codeVerificationRootViewNotification"), object: nil)
                            
                        }.foregroundColor(Color.deep_purple_500)
                    }
            )
        }.accentColor(Color.deep_purple_500)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
