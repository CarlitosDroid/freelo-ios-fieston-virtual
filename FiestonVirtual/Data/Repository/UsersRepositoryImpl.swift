//
//  UseesRepositoryImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine
import CoreData

class UsersRepositoryImpl {
    
    private let repository: CoreDataRepository<UserEntity>
    
    private let context: NSManagedObjectContext
    
    //    let userLocalDataSource: UserLocalDataSource
    //
    //    init(userLocalDataSource: UserLocalDataSource) {
    //        self.userLocalDataSource = userLocalDataSource
    //    }
    
    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<UserEntity>(managedObjectContext: context)
        self.context = context
    }
    
    
    //    func setLoggedInUser() {
    //        self.userLocalDataSource.saveUser()
    //    }
    //
    //    func getLocalUsers() -> [User] {
    //        return self.userLocalDataSource.getUsers()
    //    }
    
}

extension UsersRepositoryImpl: UsersRepository {
    
    @discardableResult func create(user: User) -> Result<Bool, Error> {
        let result = repository.create()
        switch result {
        case .success(let userEntity):
            userEntity.name = user.name
            userEntity.age = user.age
            
            do {
                try context.save()
            } catch {
                fatalError("Failed to fetch books: \(error)")
            }
            
            return .success(true)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    @discardableResult func getLocalUsers(predicate: NSPredicate?) -> Result<[User], Error> {
    
        //TODO: Use this predicate when you want to filter
//        let filter = "CarlitosDroid"
//        let commitPredicate = NSPredicate(format: "name == %@", filter)

        let result = repository.get(predicate: nil, sortDescriptors: nil)
        switch result {
        case .success(let userEntities):
            let users = userEntities.map { (userEntity: UserEntity) in
                return userEntity.toDomainModel()
            }

            return .success(users)
        case .failure(let error):
            return .failure(error)
        }
    }
}
