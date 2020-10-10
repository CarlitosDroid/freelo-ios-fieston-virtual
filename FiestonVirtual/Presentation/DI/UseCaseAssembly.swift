//
//  UseCaseAssembly.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject

class UseCasesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LoginUseCase.self) { resolver in
            LoginUseCaseImpl(
                eventCodeRepository: resolver.resolve(EventCodeRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        container.register(VerifySessionUseCase.self) { resolver in
            VerifySessionUseCaseImpl(
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(GetWelcomeUseCase.self) { resolver in
            GetWelcomeUseCaseImpl(
                eventRepository : resolver.resolve(EventCodeRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        container.register(SignOutUseCase.self) { resolver in
            SignOutUseCaseImpl(
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        container.register(GetGalleryUseCase.self) { resolver in
            GetGalleryUseCaseImpl(
                galleryRepository: resolver.resolve(GalleryRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(GetPostDetailUseCase.self) { resolver in
            GetPostDetailUseCaseImpl(
                galleryRepository: resolver.resolve(GalleryRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(GetCommentsUseCase.self) { resolver in
            GetCommentsUseCaseImpl(
                commentsRepository: resolver.resolve(CommentsRepository.self)!
            )
        }
        
        container.register(AddCommentUseCase.self) { resolver in
            AddCommentUseCaseImpl(
                commentsRepository: resolver.resolve(CommentsRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(MakeLikeUseCase.self) { resolver in
            MakeLikeUseCaseImpl(
                usersRepository: resolver.resolve(UsersRepository.self)!,
                likeRepository: resolver.resolve(LikeRepository.self)!
            )
        }
        
        container.register(GetTriviaUseCase.self) { resolver in
            GetTriviaUseCaseImpl(
                triviaRepository: resolver.resolve(TriviaRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(AnswerTriviaUseCase.self) { resolver in
            AnswerTriviaUseCaseImpl(
                triviaRepository: resolver.resolve(TriviaRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(UploadFileUseCase.self) { resolver in
            UploadFileUseCaseImpl(
                galleryRepository: resolver.resolve(GalleryRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(UploadProfileImageUseCase.self) { resolver in
            UploadProfileImageUseCaseImpl(
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(GetRankingUseCase.self) { resolver in
            GetRankingUseCaseImpl(
                rankingRepository: resolver.resolve(RankingRepository.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
    }
}
