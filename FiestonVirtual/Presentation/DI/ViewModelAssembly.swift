
import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(WelcomeViewModel.self) { resolver in
            WelcomeViewModel(getWelcomeUseCase: resolver.resolve(GetWelcomeUseCase.self)!)
        }
        
        container.register(CodeVerificationViewModel.self) { resolver in
            CodeVerificationViewModel(
                loginUseCase: resolver.resolve(LoginUseCase.self)!,
                verifySessionUseCase: resolver.resolve(VerifySessionUseCase.self)!
            )
        }
        
        container.register(MainViewModel.self) { resolver in
            MainViewModel(signOutUseCase: resolver.resolve(SignOutUseCase.self)!)
        }
        
    }
}
