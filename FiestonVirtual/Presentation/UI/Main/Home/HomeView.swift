//
//  HomeView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import Grid

struct HomeView: View {
    
    
    let colors = [
        Color1(name: Color.green),
        Color1(name: Color.red),
        Color1(name: Color.orange),
        Color1(name: Color.black),
        Color1(name: Color.purple)
    ]
    
    let categories = [
        Category(
            name: "FOTOS",
            image: "home_fotos",
            description: "nose",
            subDescription: "subde"),
        Category(
            name: "FOTOS",
            image: "home_chat",
            description: "nose",
            subDescription: "subde"),
        Category(
            name: "FOTOS",
            image: "home_playlist",
            description: "nose",
            subDescription: "subde"),
        Category(
            name: "FOTOS",
            image: "home_trivia",
            description: "nose",
            subDescription: "subde")
    ]
    
    
    var body: some View {
        ZStack {
            
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                UserProfileView()
                
                Grid(categories) { category in
                    self.categoryView(category: category)
                }.gridStyle(
                    StaggeredGridStyle(.vertical,
                                       tracks:2,
                                       spacing: 10)
                )
                
            }.padding(.all, 10)
        }
        
    }
    
    func categoryView(category: Category) -> some View {
        VStack {
            Image(category.image)
                .resizable()
                .scaledToFit()
                .background(Color.red)
            VStack {
                
                Text("Hola")
                Text("Hola")
                Text("Hola")
                
            }.padding(.all, 20)
        }.background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
    }
}


struct Category: Identifiable {
    var id: UUID = UUID()
    let name: String
    let image: String
    let description: String
    let subDescription: String
}

struct Color1 : Identifiable {
    var id: String = UUID().uuidString
    var name: Color = Color.orange_500
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
