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
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var inSession = false
    
    private var disposables = Set<AnyCancellable>()
    
    init(loginUseCase: LoginUseCase, verifySessionUseCase: VerifySessionUseCase) {
        self.loginUseCase = loginUseCase
        self.verifySessionUseCase = verifySessionUseCase
    }
    
    
    func verifyCode(code: String) {
        self.isLoading = true
        if (!code.isEmpty) {
            loginUseCase.invoke(userInvitationCode: Int(code)!)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                switch completion {
                case .finished:
                    print("finisheddd")
                    break
                case .failure(let errorResponse):
                    self.isLoading = false
                    self.errorMessage = errorResponse.localizedDescription
                    print("\(self.errorMessage)")
                 
                    break
                }
            }, receiveValue: { (eventCode: Bool) in
                self.isLoading = false
                self.inSession = true
            })
            .store(in: &disposables)
        }
    }
    
    func verifySession() {
        let result = self.verifySessionUseCase.invoke()
        switch result {
        case .success(let inSession):
            self.inSession = inSession
            break
        case .failure(let error):
            print(error)
            break
        }
    }
    
}
