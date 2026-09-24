
import Foundation
import Combine

class TriviaDataSourceImpl : TriviaDataSource {
    
    private let triviaApi : TriviaApi
    
    init(triviaApi:TriviaApi){
        self.triviaApi = triviaApi
    }
    
    func getTrivia(triviaRequest: TriviaRequest) -> AnyPublisher<[Trivia], ErrorResponse> {
        self.triviaApi.getTrivia(triviaRequest : triviaRequest)
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
            .map{ (triviaResponse : TriviaResponse) -> [Trivia] in
                return triviaResponse.data.question.map{
                    (childQuestion : ChildQuestion) in
                    childQuestion.toTrivia()
                }
            }.eraseToAnyPublisher()
    }
    
    func answerTrivia(
        answerTriviaRequest: AnswerTriviaRequest
    ) -> AnyPublisher<AnswerTriviaResponse, ErrorResponse> {
        self.triviaApi.answerTrivia(answerTriviaRequest : answerTriviaRequest)
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
            .map{ (answerTriviaResponseEntity : AnswerTriviaResponseEntity) -> AnswerTriviaResponse in
                return answerTriviaResponseEntity.toDomain()
            }.eraseToAnyPublisher()
    }
    
    
}
