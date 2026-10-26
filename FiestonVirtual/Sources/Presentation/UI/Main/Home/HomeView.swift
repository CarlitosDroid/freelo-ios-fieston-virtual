//
//  HomeView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

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
            
            LinearGradient(
                colors: [
                    Color.loginGradientStart,
                    Color.loginGradientMiddle,
                    Color.loginGradientEnd
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            LoadingView(isShowing: self.$viewModel.isLoading) {
                ScrollView {
                    HomeNowPlayingView()
                        .padding(.bottom, 10)

                    HomeWelcomeCard(
                        user: self.$user,
                        imageUrl: $userProfileImageUrl
                    ) {
                        self.isShowingImagePicker.toggle()
                    }
                    .sheet(isPresented: $isShowingImagePicker) {
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
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ],
                        spacing: 14
                    ) {
                        ForEach(viewModel.categories) { category in
                            HomeFeatureCard(category: category) {
                                self.onCategorySelected(category.destinationIndex)
                            }
                        }
                    }
                    
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
    
}
