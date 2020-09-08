//
//  CodeVerificationViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine
import CoreData

class CodeVerificationViewModel: ObservableObject {
    
    let loginUseCase: LoginUseCase
    let verifySessionUseCase: VerifySessionUseCase
    
    @Published var eventCode: EventCode?
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private var disposables = Set<AnyCancellable>()
    
    init(loginUseCase: LoginUseCase, verifySessionUseCase: VerifySessionUseCase) {
        self.loginUseCase = loginUseCase
        self.verifySessionUseCase = verifySessionUseCase
    }
    
    func verifyCode() {
        self.isLoading = true
        loginUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                switch completion {
                case .finished:
                    self.isLoading = false
                    break
                case .failure(let errorResponse):
                    self.errorMessage = errorResponse.localizedDescription
                    print("\(self.errorMessage)")
                    self.isLoading = false
                    break
                }
            }, receiveValue: { (eventCode: Bool) in
                self.isLoading = false
                print("\(eventCode)")
            })
            .store(in: &disposables)
    }
    
    func inserrt() {
        //        let coreDataContextProvider = CoreDataContextProvider()
        //        let context = coreDataContextProvider.viewContext
        //
        //        let bookRepository = CoreDataRepository<UserEntity>(managedObjectContext: context)
        //
        //        let bookResult = bookRepository.create()
        //        switch bookResult {
        //        case .success(let userEntity):
        //            userEntity.name = "The Swift Handbook"
        //        case .failure(let error):
        //            fatalError("Failed to create book: \(error)")
        //        }
        //
        //        do {
        //            try context.save()
        //        } catch {
        //            fatalError("Failed to fetch books: \(error)")
        //        }
    }
    
    
    func readd() {
        
        let result = self.verifySessionUseCase.invoke()
        
        switch result {
        case .success(let users):
            print(users)
            break
        case .failure(let error):
            print(error)
            break
        }
        
        //        let coreDataContextProvider = CoreDataContextProvider()
        //        let moc = coreDataContextProvider.viewContext
        //        let bookFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        //
        //
        //        do {
        //            let fetchedBooks = try moc.fetch(bookFetch) as! [UserEntity]
        //            fetchedBooks.forEach { (userEntity: UserEntity) in
        //                print(userEntity.name)
        //            }
        //        } catch {
        //            fatalError("Failed to fetch books: \(error)")
        //        }
    }
}
