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
        ZStack {
            LoadingView(isShowing: .constant(viewModel.isLoading)){
                ZStack {
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
                    }.navigationBarBackButtonHidden(true)
                    
                    WelcomeView(
                        welcome:self.viewModel.welcome,
                        showSheet: self.viewModel.hasWelcome
                    )
                }
                
            }
        } .onAppear{
            self.viewModel.getWelcome()
        }
    }
}

/*
 struct MainView_Previews: PreviewProvider {
 static var previews: some View {
 //MainView()
 }
 }
 */
