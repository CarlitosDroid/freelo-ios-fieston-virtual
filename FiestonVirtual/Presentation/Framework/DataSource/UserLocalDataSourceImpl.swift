//
//  UserLocalDataSourceImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import CoreData
import Combine

class UserLocalDataSourceImpl: UserLocalDataSource {
    
//    @Environment(\.managedObjectContext) var managedObjectContext
//
//    @FetchRequest(
//        entity: UserEntity.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \UserEntity.name, ascending: true)
//        ]
//    ) var userEntities: FetchedResults<UserEntity>
    
//    var managedObjectContext: NSManagedObjectContext
    
    init() {
        //self.managedObjectContext = managedObjectContext
    }
    
    func saveUser() {
        addUser()
    }
    
    private func addUser() {
//        let userEntity = UserEntity(context: managedObjectContext)
//
//        print(managedObjectContext)
//        userEntity.name = "Carlos"
//        userEntity.age = "87"
//        saveContext()
    }
    
    func getUsers() {
//        return userEntities.map { (userEntity: UserEntity) -> User in
//            userEntity.toUser()
//        }
    }
    
    func saveContext() {
//        do {
//            try managedObjectContext.save()
//        } catch {
//            print("Error saving managed object context \(error.localizedDescription)")
//        }
    }
    
}
