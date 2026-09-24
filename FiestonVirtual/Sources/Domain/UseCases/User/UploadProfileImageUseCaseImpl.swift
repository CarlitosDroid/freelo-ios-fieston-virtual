//
//  UploadProfileImageUseCaseImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class UploadProfileImageUseCaseImpl: UploadProfileImageUseCase {
    
    private let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func invoke(imageProfileURL: URL) -> AnyPublisher<ProfileImage, ErrorResponse> {
        switch usersRepository.getLocalUser() {
        case .success(let user):
            return self.usersRepository.uploadProfileImage(profileImageURL: imageProfileURL, userId: user.id)
        case .failure(let error):
            return Fail(error: error).mapError { (error: Error) -> ErrorResponse in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }.eraseToAnyPublisher()
        }
        
    }
    
}
