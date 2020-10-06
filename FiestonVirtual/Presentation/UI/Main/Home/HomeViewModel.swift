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
            image: "home_fotos",
            description: "GALERÍA DE FOTOS Y",
            subDescription: "VIDEOS"),
        Category(
            name: CATEGORY_NAME_CHAT,
            image: "home_chat",
            description: "CHATEAR AHORA",
            subDescription: "ARMA LA CONVERSA"),
        Category(
            name: CATEGORY_NAME_TRIVIA,
            image: "home_trivia",
            description: "GANA PUNTOS",
            subDescription: "JUGAR AHORA"),
        Category(
            name: CATEGORY_NAME_PLAY_LIST,
            image: "home_playlist",
            description: "PARTICIPA DE LA FIESTA",
            subDescription: "PIDE UNA CANCIÓN")
    ]
    
    
    @Published var isLoading = false
    @Published var uploadPhotoMessage = ""
    @Published var uploadImageProfileResponse: UploadImageProfileResponse?
    
    @Published var user: User?
    
    private let usersRepository: UsersRepository
    
    private var disposables = Set<AnyCancellable>()
    
    init(
        usersRepository: UsersRepository
    ){
        self.usersRepository = usersRepository
    }
    
    // TODO - USE THE SELFIE WEB SERVICE
    func uploadProfileImageFile(data: URL) {
        
        switch usersRepository.getLocalUser() {
        
        case .success(let user):
            
            isLoading = true
            let userApi = UserApiImpl()
            userApi.uploadProfileImage(
                data: data,
                idUser: user.id)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion: Subscribers.Completion<ExternalError>) in
                    self.isLoading = false
                    switch completion {
                    case .finished:
                        print("finish")
                        break
                    case .failure(let errorResponse):
                        self.uploadPhotoMessage = errorResponse.localizedDescription
                        break
                    }
                }, receiveValue: { (uploadImageProfileResponse: UploadImageProfileResponse) in
                    print(uploadImageProfileResponse)
                    self.uploadImageProfileResponse = uploadImageProfileResponse
                    self.usersRepository.update(avatarName: uploadImageProfileResponse.data.post.postFile)
                })
                .store(in: &disposables)
            
            
            break
        case .failure( let error):
            //            return Just([]).mapError({ (_) in
            //                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            //            }).eraseToAnyPublisher()
            
            break
        }
        
        
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
