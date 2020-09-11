
import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(WelcomeViewModel.self) { resolver in
            WelcomeViewModel(getWelcomeUseCase: resolver.resolve(GetWelcomeUseCase.self)!)
        }
        
    }
}
