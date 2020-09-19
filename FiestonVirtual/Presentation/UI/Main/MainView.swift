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
    @ObservedObject var mainviewModel = DependencyProvider().assembler.resolver.resolve(MainViewModel.self)!
    
    @State var showAlert = false
    
    @State private var selectedTab = 0
    
    @State var showPlayListView: Bool = false
    
    @State var showCaptureImageView: Bool = false
    
    @State var showWelcomeOnlyOnce = true
    
    var body: some View {
        
        LoadingView(isShowing: self.$viewModel.isUploadingPhoto) {
            
            NavigationView {
                ZStack {
                    VStack(spacing:0) {
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
                    
                    NavigationLink(destination: PlayListView(), isActive: $showPlayListView){
                        EmptyView()
                    }
                    
                    NavigationLink(
                        destination: CaptureImageView(isShown: $showCaptureImageView) { image in
                            guard let data = image.jpegData(compressionQuality: 0.8) else { return }
                            self.viewModel.uploadImage(data: data)
                        },
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
                    
                    trailing: Button("Salir") {
                        self.showAlert.toggle()
                        // TODO - CALL THIS METHOD ONCE DATABASE IS EMPTY AFTER LOG OUT
                        //NotificationCenter.default.post(name: NSNotification.Name("codeVerificationRootViewNotification"), object: nil)
                        
                    }.foregroundColor(Color.deep_purple_500)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("¿Cerrar sesión?"),
                            primaryButton: .cancel(Text("No"), action: {}),
                            secondaryButton: .destructive(Text("Si"), action: {
                                self.mainviewModel.signOut()
                            })
                        )
                    }
                )
            }.accentColor(Color.deep_purple_500)
            
        }.onAppear{
            if(showWelcomeOnlyOnce) {
                self.viewModel.getWelcome()
                self.showWelcomeOnlyOnce = false
            }
        }.alert(isPresented: self.$viewModel.uploadPhotoHasFinished, content: {
            Alert(
                title: Text(self.viewModel.uploadPhotoMessage),
                dismissButton: .default(Text("Aceptar"))
            )
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
