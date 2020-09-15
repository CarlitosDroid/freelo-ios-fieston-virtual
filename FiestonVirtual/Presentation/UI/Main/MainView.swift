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
    
    var body: some View {
        ZStack{
            
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
                            self.showAlert.toggle()
                        }, label: {
                            Image(systemName: "star").accentColor(Color.white)
                        }).alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("¿Cerrar sesión?"),
                                primaryButton: .cancel(Text("No"), action: {}),
                                secondaryButton: .destructive(Text("Si"), action: {
                                    self.mainviewModel.signOut()
                                })
                            )
                        }
                    }
                }.padding(10).background(Color.deep_purple_500)
                
                TabView {
                    Text("HOLA1")
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("Menu")
                    }
                    PhotosView()
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("Menu")
                    }
                    
                }
                
                WelcomeView(
                    welcome:.constant(self.viewModel.welcome),
                    showSheet: .constant( self.viewModel.hasWelcome)
                )
            }
            LoadingView(isShowing: .constant(self.mainviewModel.isLoading)) {
                          NavigationLink(
                              destination: CodeVerificationView(),
                              isActive: self.$mainviewModel.isClosedSession,
                              label:{EmptyView()}
                          )
                      }
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
