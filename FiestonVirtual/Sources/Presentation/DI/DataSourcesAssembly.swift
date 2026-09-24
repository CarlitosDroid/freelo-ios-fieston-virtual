//
//  DataSourcesAssembly.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject

class DataSourcesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UserRemoteDataSource.self) { (resolver: Resolver) in
            UserRemoteDataSourceImpl(userApi: resolver.resolve(UserApi.self)!)
        }
        
        container.register(UserLocalDataSource.self) { (resolver: Resolver) in
            UserLocalDataSourceImpl()
        }
        
        container.register(EventCodeRemoteDataSource.self) { (resolver: Resolver) in
            EventCodeRemoteDataSourceImpl(eventCodeApi: resolver.resolve(EventCodeApi.self)!)
        }
        
        container.register(GalleryDataSource.self) { (resolver: Resolver) in
            GalleryDataSourceImpl(
                galleryApi: resolver.resolve(GalleryApi.self)!
            )
        }
        
        container.register(CommentsRemoteDataSource.self) { (resolver: Resolver) in
            CommentsRemoteDataSourceImpl(commentsApi: resolver.resolve(CommentsApi.self)!)
        }
        
        container.register(LikeDataSource.self) { (resolver: Resolver) in
            LikeDataSourceImpl(likeApi: resolver.resolve(LikeApi.self)!)
        }
        
        container.register(TriviaDataSource.self) { (resolver: Resolver) in
            TriviaDataSourceImpl(triviaApi: resolver.resolve(TriviaApi.self)!)
        }
        
        container.register(RankingRemoteDataSource.self) { (resolver: Resolver) in
            RankingRemoteDataSourceImpl(rankingApi: resolver.resolve(RankingApi.self)!)
        }
        
        container.register(PlaylistDataSource.self) { (resolver: Resolver) in
            PlaylistDataSourceImpl(playListApi: resolver.resolve(PlayListApi.self)!)
        }
        
        container.register(ChatMessageDataSource.self) { (resolver: Resolver) in
            ChatMessageDataSourceImpl(
                chatMessagesApi: resolver.resolve(ChatMessagesApi.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(FcmDataSource.self) { (resolver: Resolver) in
            FcmDataSourceImpl(
                fcmApi: resolver.resolve(FcmApi.self)!
            )
        }
        
    }
    
}
