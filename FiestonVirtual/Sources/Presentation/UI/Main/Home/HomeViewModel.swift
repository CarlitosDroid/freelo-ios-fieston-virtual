//
//  HomeViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/15/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    let categories = [
        Category(
            titleKey: "home.card.photos.title",
            subtitleKey: "home.card.photos.subtitle",
            badgeKey: "home.card.photos.badge",
            icon: "photo.on.rectangle",
            accentColor: .aquamarine,
            destinationIndex: 1),
        Category(
            titleKey: "home.card.chat.title",
            subtitleKey: "home.card.chat.subtitle",
            badgeKey: "home.card.chat.badge",
            icon: "bubble.left",
            accentColor: .chatPink,
            destinationIndex: 3),
        Category(
            titleKey: "home.card.playlist.title",
            subtitleKey: "home.card.playlist.subtitle",
            badgeKey: "home.card.playlist.badge",
            icon: "music.note",
            accentColor: .loginBrandPurple,
            destinationIndex: 8),
        Category(
            titleKey: "home.card.trivia.title",
            subtitleKey: "home.card.trivia.subtitle",
            badgeKey: "home.card.trivia.badge",
            icon: "questionmark.square.fill",
            accentColor: .loginAccentYellow,
            destinationIndex: 4)
    ]
    
    
    @Published var isLoading = false
    @Published var uploadPhotoMessage = ""
    @Published var profileImage: ProfileImage?
    @Published var user: User?
    
    
    private let uploadProfileImageUseCase: UploadProfileImageUseCase
    private let usersRepository: UsersRepository
    
    private var disposables = Set<AnyCancellable>()
    
    init(
        uploadProfileImageUseCase: UploadProfileImageUseCase,
        usersRepository: UsersRepository
    ) {
        self.uploadProfileImageUseCase = uploadProfileImageUseCase
        self.usersRepository = usersRepository
    }
    
    // TODO - USE THE SELFIE WEB SERVICE
    func uploadProfileImageFile(data: URL) {
        isLoading = true
        self.uploadProfileImageUseCase.invoke(imageProfileURL: data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    print("finish")
                    break
                case .failure(let errorResponse):
                    self.uploadPhotoMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (profileImage: ProfileImage) in
                print(profileImage)
                self.profileImage = profileImage
                self.usersRepository.updateLocalUserBy(avatarName: profileImage.imageUrl)
            })
            .store(in: &disposables)
    }
    
    func getUser() {
        switch usersRepository.getLocalUser() {
        case .success(let user):
            self.user = user
            return
        case .failure( _):
            return
        }
        
    }
    
}
