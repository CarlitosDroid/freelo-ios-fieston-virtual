//
//  RepositoriesAssembly.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject

class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(EventCodeRepository.self) { resolver in
            EventCodeRepositoryImpl(eventCodeRemoteDataSource: resolver.resolve(EventCodeRemoteDataSource.self)!)
        }
        
        container.register(UsersRepository.self) { resolver in
            let coreDataContext = CoreDataContextProvider().viewContext
            return UsersRepositoryImpl(context: coreDataContext,
                                       userRemoteDataSource: UserRemoteDataSourceImpl(userApi: resolver.resolve(UserApi.self)!))
        }
        
        container.register(GalleryRepository.self) { resolver in
            GalleryRepositoryImpl(
                galleryDataSource: resolver.resolve(GalleryDataSource.self)!
            )
        }
        
        container.register(CommentsRepository.self) { resolver in
            CommentsRepositoryImpl(commentsRemoteDataSource: resolver.resolve(CommentsRemoteDataSource.self)!)
        }
        
        container.register(LikeRepository.self) { resolver in
            LikeRepositoryImpl(likeDataSource: resolver.resolve(LikeDataSource.self)!)
        }
        
        container.register(TriviaRepository.self) { resolver in
            TriviaRepositoryImpl(triviaDataSource: resolver.resolve(TriviaDataSource.self)!)
        }
        
        container.register(RankingRepository.self) { resolver in
            RankingRepositoryImpl(
                rankingRemoteDataSource: resolver.resolve(RankingRemoteDataSource.self)!
            )
        }
        
    }
}
