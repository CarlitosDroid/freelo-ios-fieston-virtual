//
//  HomeView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import Grid
import KingfisherSwiftUI
import QGrid

struct HomeView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(HomeViewModel.self)!
    
    var onCategorySelected: (_ categoryIndex: Int) -> Void
    
    @State var isShowingImagePicker = false
    @State var imageInBlackBox: UIImage?
    @State var fileURL: URL?
    @State var fileType = ""
    @State private var isImageSelected = false
    
    @State private var userProfileImageUrl: String = ""
    
    @State private var user: User?
    
    var body: some View {
        
        ZStack {
            
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            LoadingView(isShowing: self.$viewModel.isLoading) {
                ScrollView {
                    UserProfileView(
                        user: self.$user,
                        imageUrl: $userProfileImageUrl
                    ) {
                        self.isShowingImagePicker.toggle()
                    }.sheet(isPresented: $isShowingImagePicker) {
                        ImagePickerView(
                            isPresented: self.$isShowingImagePicker,
                            selectedImage: self.$imageInBlackBox,
                            fileURL: self.$fileURL,
                            fileType: self.$fileType
                        ) { isImageSelected, fileURL in
                            self.isImageSelected = isImageSelected
                            self.viewModel.uploadProfileImageFile(data: fileURL)
                        }
                    }
                    
                    Grid(viewModel.categories) { category in
                        self.categoryView(category: category)
                    }.gridStyle(
                        StaggeredGridStyle(.vertical, tracks:2, spacing: 10)
                    )
                    
                }
                .padding(.all, 10)
            }
            
        }
        .onAppear{
            self.viewModel.getUser()
        }
        .onReceive(viewModel.$profileImage) { (nullProfileImage) in
            guard let nonNullProfileImage = nullProfileImage else { return }
            
            self.userProfileImageUrl = nonNullProfileImage.imageUrl
        }.onReceive(viewModel.$user, perform: { user in
            if (user == nil){ return }
            self.user = user!
            self.userProfileImageUrl = user!.avatar
        })
        
    }
    
    func categoryView(category: Category) -> some View {
        VStack {
            Image(category.image)
                .resizable()
                .scaledToFit()
                .background(Color.red)
            
            VStack(spacing: 0, content: {
                
                Text(category.name)
                    .foregroundColor(.deep_purple_500)
                    .bold()
                    .font(.system(size:20))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                Text(category.description)
                    .foregroundColor(.gray)
                    .font(.system(size:14))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                Text(category.subDescription)
                    .foregroundColor(.deep_purple_500)
                    .bold()
                    .font(.system(size:14))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
            })
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.bottom, 10)
            
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
