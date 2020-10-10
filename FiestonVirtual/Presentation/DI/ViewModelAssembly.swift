
import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(MainViewModel.self) { resolver in
            MainViewModel(
                getWelcomeUseCase: resolver.resolve(GetWelcomeUseCase.self)!,
                signOutUseCase: resolver.resolve(SignOutUseCase.self)!
            )
        }
        
        container.register(CodeVerificationViewModel.self) { resolver in
            CodeVerificationViewModel(
                loginUseCase: resolver.resolve(LoginUseCase.self)!,
                verifySessionUseCase: resolver.resolve(VerifySessionUseCase.self)!
            )
        }
        
        container.register(HomeViewModel.self) { resolver in
            HomeViewModel(
                uploadProfileImageUseCase: resolver.resolve(UploadProfileImageUseCase.self)!,
                usersRepository: resolver.resolve(UsersRepository.self)!)
        }
        
        container.register(GalleryViewModel.self) { resolver in
            GalleryViewModel(
                getGalleryUseCase: resolver.resolve(GetGalleryUseCase.self)!
            )
        }
        
        container.register(GalleryDetailViewModel.self) { resolver in
            GalleryDetailViewModel(
                getCommentsUseCase: resolver.resolve(GetCommentsUseCase.self)!,
                getPostDetailUseCase: resolver.resolve(GetPostDetailUseCase.self)!,
                addCommentUseCase: resolver.resolve(AddCommentUseCase.self)!,
                makeLikeUseCase: resolver.resolve(MakeLikeUseCase.self)!
            )
        }
        
        container.register(TriviaViewModel.self) { resolver in
            TriviaViewModel(
                getTriviaUseCase: resolver.resolve(GetTriviaUseCase.self)!,
                answerTriviaUseCase: resolver.resolve(AnswerTriviaUseCase.self)!
            )
        }
    
        container.register(PhotosViewModel.self) { resolver in
            PhotosViewModel(
                uploadFileUseCase: resolver.resolve(UploadFileUseCase.self)!
            )
        }
        
        container.register(SocketIOViewModel.self) { resolver in
            SocketIOViewModel(
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        
        container.register(RankingViewModel.self) { resolver in
            RankingViewModel(
                getRankingUseCase: resolver.resolve(GetRankingUseCase.self)!
            )
        }
        
    }
}
