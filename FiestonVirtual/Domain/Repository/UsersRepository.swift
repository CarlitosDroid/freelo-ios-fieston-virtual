//
//  UserRepository.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol UsersRepository {
    func getLocalUsers(predicate: NSPredicate?) -> Result<[User], Error>
    func create(user: User) -> Result<Bool, Error>
    
    func getRemoteUser(idUser: Int) -> AnyPublisher<User, ErrorResponse>
}
