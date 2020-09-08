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
    
    let loginUseCase = DependencyProvider().assembler.resolver.resolve(LoginUseCase.self)!
    let verifySessionUseCase = DependencyProvider().assembler.resolver.resolve(VerifySessionUseCase.self)!
    
    @Published var eventCode: EventCode?
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var isSuccessCode = false
    
    private var disposables = Set<AnyCancellable>()
    
    init() {
    }
    
    func verifyCode(code: String) {
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
                self.isSuccessCode = true
            })
            .store(in: &disposables)
    }
    
    func verifySession() {
        let result = self.verifySessionUseCase.invoke()
        switch result {
        case .success(let users):
            print(users)
            break
        case .failure(let error):
            print(error)
            break
        }
    }
}
