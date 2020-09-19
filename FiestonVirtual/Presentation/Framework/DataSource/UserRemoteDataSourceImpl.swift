//
//  UserRemoteDataSourceImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class UserRemoteDataSourceImpl: UserRemoteDataSource {
    
    private let userApi: UserApi
    
    init(userApi: UserApi) {
        self.userApi = userApi
    }
    
    func getUsers(idUser: Int) -> AnyPublisher<User, ErrorResponse> {
        return userApi.getUserData(idUser: idUser)
            .mapError { (externalError: ExternalError) -> ErrorResponse in
                switch externalError {
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
        }
        .map { (userResponseEntity: UserResponse) -> User in
            return userResponseEntity.toDomainModel()
        }.eraseToAnyPublisher()
    }
    
    func signOut(signOutRequest: SignOutRequest) -> AnyPublisher<Bool, ErrorResponse> {
        return userApi.signOut(signOutRequest: signOutRequest)
            .mapError { (ExternalError: ExternalError) -> ErrorResponse in
                switch ExternalError{
                case .NetworkError(let description):
                    return ErrorResponse(title: "Error en la red", message: description)
                case .Parsing(let description):
                    return ErrorResponse(title: "Error al parsear", message: description)
                case .UnknowError(let description):
                    return ErrorResponse(title: "Error Desconocido", message: description)
                }
        }
        .map{(signOutResponse:SignOutResponse)-> Bool in
            return signOutResponse.data.rpta
        }.eraseToAnyPublisher()
    }
}
