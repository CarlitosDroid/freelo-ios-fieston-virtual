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
    
    // LOCAL DATA BASE OPERATIONS
    func getLocalUsers(predicate: NSPredicate?) -> Result<[User], Error>
    func createLocalUser(user: User) -> Result<Bool, Error>
    func getLocalUser() -> Result<User, Error>
    func updateLocalUserBy(avatarName: String)
    func deleteLocalAllUsers()-> Result<Bool,Error>
    func updateLocalTotalScoreOfUser(totalScore : Int)
    func updateLocalToken(token : String)
    
    // REMOTE OPERATIONS
    func getRemoteUser(idUser: Int) -> AnyPublisher<User, ErrorResponse>
    func signOut(signOutRequest: SignOutRequest) -> AnyPublisher<Bool, ErrorResponse>
    func uploadProfileImage(profileImageURL: URL, userId: Int) -> AnyPublisher<ProfileImage, ErrorResponse>
    
}
