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
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(HomeViewModel.self)!
    
    var onCategorySelected: (_ categoryIndex: Int) -> Void
    
    var body: some View {
        ZStack {
            
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                UserProfileView()
                
                Grid(viewModel.categories) { category in
                    self.categoryView(category: category)
                }.gridStyle(
                    StaggeredGridStyle(.vertical, tracks:2, spacing: 10)
                )
                
            }
            .padding(.all, 10)
        }
        
    }
    
    func categoryView(category: Category) -> some View {
        VStack {
            Image(category.image)
                .resizable()
                .scaledToFit()
                .background(Color.red)
            
            VStack(alignment: .leading, spacing: 0, content: {
                
                Text(category.name)
                    .foregroundColor(.deep_purple_500)
                    .bold()
                    .font(.system(size:20))
                
                Text(category.description)
                    .foregroundColor(.gray)
                    .font(.system(size:14))
                
                Text(category.subDescription)
                    .foregroundColor(.deep_purple_500)
                    .bold()
                    .font(.system(size:14))
            })
            .padding(.leading, 5)
            .padding(.trailing, 5)
            .padding(.bottom, 5)
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .onTapGesture {
            switch (category.name) {
            case CATEGORY_NAME_PHOTO:
                self.onCategorySelected(1)
                break
            case CATEGORY_NAME_CHAT:
                self.onCategorySelected(3)
                break
            case CATEGORY_NAME_PLAY_LIST:
                self.onCategorySelected(8)
                break
            case CATEGORY_NAME_TRIVIA:
                self.onCategorySelected(4)
                break
            default:
                print("Not supported")
            }
        }
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
        HomeView { (categorIndex: Int) in
            
        }
    }
}
