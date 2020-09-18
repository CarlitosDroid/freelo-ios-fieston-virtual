
import Foundation
import Combine

class SignOutUseCaseImpl : SignOutUseCase{
    
    private let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository){
        self.usersRepository = usersRepository
    }
    
    func invoke() -> AnyPublisher<Bool, ErrorResponse> {
        let result = self.usersRepository.getLocalUser()
        
        switch result {
        
        case .success(let user):
            return self.usersRepository.signOut(signOutRequest: SignOutRequest(idUser: user.id)).flatMap{(isClosedSession:Bool)->AnyPublisher<Bool,ErrorResponse> in
                if(isClosedSession){
                    self.usersRepository.deleteLocalAllUsers()
                }
            }.eraseToAnyPublisher()
            
        case .failure(let error):
            return Just(false).mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
    }
    
}
