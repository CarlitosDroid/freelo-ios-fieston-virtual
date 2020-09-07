//
//  CodeVerificationViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class CodeVerificationViewModel: ObservableObject {
    
    let loginUseCase: LoginUseCase
    
    @Published var eventCode: EventCode?
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private var disposables = Set<AnyCancellable>()
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
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
                    self.isLoading = false
                    break
                }
            }, receiveValue: { (eventCode: EventCode) in
                self.isLoading = false
                print("\(eventCode)")
            })
            .store(in: &disposables)
    }
}
