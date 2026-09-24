//
//  ApiAssembly.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Swinject

class ApiAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UserApi.self) { _ in
            UserApiImpl()
        }
        
        container.register(EventCodeApi.self) { _ in
            EventCodeApiImpl()
        }
        
        container.register(GalleryApi.self) { _ in
            GalleryApiImpl()
        }
        
        container.register(CommentsApi.self) { _ in
            CommentsApiImpl()
        }
        
        container.register(LikeApi.self) { _ in
            LikeApiImpl()
        }
        
        container.register(TriviaApi.self) { _ in
            TriviaApiImpl()
        }
        
        container.register(RankingApi.self) { _ in
            RankingApiImpl()
        }
        
        container.register(PlayListApi.self) { _ in
            PlayListApiImpl()
        }
        
        container.register(ChatMessagesApi.self) { _ in
            ChatMessagesApiImpl()
        }
        
        container.register(FcmApi.self) { _ in
            FcmApiImpl()
        }
        
    }
    
}
