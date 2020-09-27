
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
            HomeViewModel()
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
    
    }
}
