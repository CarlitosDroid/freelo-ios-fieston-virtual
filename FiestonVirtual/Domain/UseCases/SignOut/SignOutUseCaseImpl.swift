
import Foundation
import Combine

class SignOutUseCaseImpl : SignOutUseCase{
    
    private let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository){
        self.usersRepository = usersRepository
    }
    
    func invoke() -> AnyPublisher<Bool, ErrorResponse> {
        let resultgetLocalUser = self.usersRepository.getLocalUser()
        
        switch resultgetLocalUser {
        
        case .success( _):
            return self.usersRepository.signOut(signOutRequest: SignOutRequest(idUser: 7)).flatMap{(isClosedSession:Bool)->AnyPublisher<Bool,ErrorResponse> in
                let result = self.usersRepository.deleteLocalAllUsers()
                switch result{
                
                case .success(_):
                    return Just(true).mapError({ (_) in
                        ErrorResponse(code: 1, title: "", message: "")
                    }).eraseToAnyPublisher()
                case .failure(_):
                    return Just(false).mapError({ (_) in
                        ErrorResponse(code: 1, title: "", message: "")
                    }).eraseToAnyPublisher()
                }
                
            }.eraseToAnyPublisher()
            
        case .failure(let error):
            return Just(false).mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
    }
    
}
