//
//  MainView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(MainViewModel.self)!
    
    @State var showAlert = false
    
    @State private var selectedTab = 0
    @State private var notifyGallery = false
    
    @State var showPlayListView: Bool = false
    
    @State var showCaptureImageView: Bool = false
    
    @State var showWelcomeOnlyOnce = true
    
    var body: some View {
        
        LoadingView(isShowing: self.$viewModel.isLoading) {
            
            NavigationView {
                ZStack {
                    VStack(spacing:0) {
                        
                        TabView(selection: $selectedTab) {
                            HomeView { (categoryIndex: Int) in
                                if(categoryIndex == 8) {
                                    self.showPlayListView = true
                                } else {
                                    self.selectedTab = categoryIndex
                                }
                                
                            }
                            .tabItem {
                                Image(systemName: "house.fill")
                                Text("Home")
                            }.tag(TAB_HOME_ID)
                            
                            GalleryView()
                                .tabItem {
                                    Image(systemName: "photo.fill.on.rectangle.fill")
                                    Text("Galeria")
                                }.tag(TAB_GALLERY_ID)
                            
                            PhotosView(selectedTab: $selectedTab, notifyGallery: $notifyGallery)
                                .tabItem {
                                    Image(systemName: "plus.app.fill")
                                    Text("Foto")
                                }.tag(TAB_PHOTO_ID)
                            
                            Text("CHAT")
                                .tabItem {
                                    Image(systemName: "bubble.left.and.bubble.right.fill")
                                    Text("Chat")
                                }.tag(TAB_CHAT_ID).foregroundColor(Color.red)
                            
                            TriviaView()
                                .tabItem {
                                    Image(systemName: "cube.box")
                                    Text("Trivia")
                                }.tag(TAB_TRIVIA_ID)
                            
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
                    
                }
                .navigationBarTitle("Fieston Virtual", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        
                        self.showCaptureImageView.toggle()
                    }) {
                        Image(systemName: "camera")
                            .foregroundColor(Color.deep_purple_500)
                            .imageScale(.large)
                    },
                    
                    trailing: Button(action: {
                        self.showAlert.toggle()
                    }){
                        Image(systemName: "arrow.right.square")
                            .foregroundColor(Color.deep_purple_500)
                            .imageScale(.large)
                    }.foregroundColor(Color.deep_purple_500)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("¿Cerrar sesión?"),
                            primaryButton: .cancel(Text("No"), action: {}),
                            secondaryButton: .destructive(Text("Si"), action: {
                                self.viewModel.signOut()
                            })
                        )
                    }
                )
            }.accentColor(Color.deep_purple_500)
            
        }.onReceive(self.viewModel.$isClosedSession, perform: { isClosedSession in
            if(isClosedSession){
                NotificationCenter.default.post(name: NSNotification.Name("codeVerificationRootViewNotification"), object: nil)
            }
        }).onAppear {
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
