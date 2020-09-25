
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
        
    }
}
