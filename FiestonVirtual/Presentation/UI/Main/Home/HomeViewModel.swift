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
            name: CATEGORY_NAME_PHOTO,
            image: "HomeFotos",
            description: "GALERÍA DE FOTOS Y",
            subDescription: "VIDEOS"),
        Category(
            name: CATEGORY_NAME_CHAT,
            image: "HomeChat",
            description: "CHATEAR AHORA",
            subDescription: "ARMA LA CONVERSA"),
        Category(
            name: CATEGORY_NAME_TRIVIA,
            image: "HomeTrivia",
            description: "GANA PUNTOS",
            subDescription: "JUGAR AHORA"),
        Category(
            name: CATEGORY_NAME_PLAY_LIST,
            image: "HomePlaylist",
            description: "PARTICIPA DE LA FIESTA",
            subDescription: "PIDE UNA CANCIÓN")
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

let CATEGORY_NAME_PHOTO = "FOTOS"
let CATEGORY_NAME_CHAT = "CHAT"
let CATEGORY_NAME_PLAY_LIST = "PLAY LIST"
let CATEGORY_NAME_TRIVIA = "TRIVIAS"
