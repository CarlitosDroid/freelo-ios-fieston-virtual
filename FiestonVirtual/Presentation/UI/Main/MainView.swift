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
    
    @State var showPlayListView: Bool = false
    
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    
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
                                self.showPlayListView = true
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
                        welcome: self.$viewModel.welcome,
                        showSheet: self.$viewModel.hasWelcome
                    )
                    
                }
                .onAppear{
                    print("PLAY LSIT \(self.showPlayListView)")
                    print("IMAGE CAPTURE \(self.showCaptureImageView)")
                    if(!self.showPlayListView && !self.showCaptureImageView) {
                        self.viewModel.getWelcome()
                    }
                }
                
                NavigationLink(destination: PlayListView(), isActive: $showPlayListView){
                    EmptyView()
                }
                
                NavigationLink(
                    destination: CaptureImageView(isShown: $showCaptureImageView, image: $image),
                    isActive: $showCaptureImageView,
                    label: {
                        EmptyView()
                    })
                //                .navigationBarBackButtonHidden(true)
                //                .navigationBarTitle("Hola")
                //                .navigationBarHidden(true)
                
            }.navigationBarTitle("Fieston Virtual", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
//                    print(showCaptureImageView)
                    
                    self.showCaptureImageView.toggle()
                }) {
                    Image(systemName: "camera")
                        .foregroundColor(Color.deep_purple_500)
                },
                
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
