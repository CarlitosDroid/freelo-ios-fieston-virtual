
import Foundation
import Combine

class FcmRepositoryImpl : FcmRepository{
    
    private let fcmDataSource : FcmDataSource
    
    init(fcmDataSource : FcmDataSource){
        self.fcmDataSource = fcmDataSource
    }
    
    func sendToken(sendTokenRequest: SendTokenRequest) -> AnyPublisher<Bool, ErrorResponse> {
        return self.fcmDataSource.sendToken(sendTokenRequest: sendTokenRequest)
    }
    
}
