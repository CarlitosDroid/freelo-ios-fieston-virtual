
import Foundation
import Combine

class SendTokenUseCaseImpl : SendTokenUseCase{
    
    private let fcmRepository : FcmRepository
    private let usersRepository : UsersRepository
    
    init(
        fcmRepository: FcmRepository,
        usersRepository : UsersRepository
    ){
        self.fcmRepository = fcmRepository
        self.usersRepository = usersRepository
    }
    
    func invoke(token: String) -> AnyPublisher<Bool, ErrorResponse> {
        
        
        switch self.usersRepository.getLocalUser(){
        
        case .success( let user):
            if(user.token != token ){
                
                return self.fcmRepository.sendToken(
                    sendTokenRequest:SendTokenRequest(
                        idUser: user.id,
                        token: token
                    )
                )
                .flatMap {
                    (answer) -> AnyPublisher<Bool, ErrorResponse> in
                    if(answer == true){
                        self.usersRepository.updateLocalToken(token: token)
                        return Just(
                            true
                        )
                        .mapError({ (_) in
                            ErrorResponse(code: 1, title: "", message: "")
                        }).eraseToAnyPublisher()
                    }else{
                        return Just(
                            false
                        )
                        .mapError({ (_) in
                            ErrorResponse(code: 1, title: "", message: "")
                        }).eraseToAnyPublisher()
                    }
                    
                }.eraseToAnyPublisher()
                
            }else{
                return Just(
                    false
                )
                .mapError({ (_) in
                    ErrorResponse(code: 1, title: "", message: "")
                }).eraseToAnyPublisher()
            }
            
        case .failure(let error):
            return Just(
                false
            )
            .mapError({ (_) in
                ErrorResponse(code: 1, title: "", message: error.localizedDescription)
            }).eraseToAnyPublisher()
            
        }
        
    }
    
}
