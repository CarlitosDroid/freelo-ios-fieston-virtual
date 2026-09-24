
import Foundation
import Combine

class LikeDataSourceImpl : LikeDataSource {
    
    private let likeApi : LikeApi
    
    init(likeApi : LikeApi){
        self.likeApi = likeApi
    }
    
    func makeLike(
        makeLikeRequest: MakeLikeRequest
    ) -> AnyPublisher<MakeLikeResponse, ErrorResponse> {
        return self.likeApi.makeLike(makeLikeRequest : makeLikeRequest)
            .mapError{ (externalError:ExternalError) -> ErrorResponse in
                switch externalError {
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
            }
            .map{ (likeResponse : LikeResponse) -> MakeLikeResponse in
                return MakeLikeResponse(likes : likeResponse.data.userLikes )
            }.eraseToAnyPublisher()
    }
    
}
