//
//  CodeVerificationView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct CodeVerificationView: View {
    
    @ObservedObject var viewModel: CodeVerificationViewModel
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {
                self.viewModel.verifyCode()
            }) {
                Text("Entrar")
            }
        }
    }
}

struct CodeVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        CodeVerificationView(viewModel: CodeVerificationViewModel(
            loginUseCase: LoginUseCaseImpl(
            eventCodeRepository: EventCodeRepositoryImpl(
                eventCodeRemoteDataSource: EventCodeRemoteDataSourceImpl(
                    eventCodeApi: EventCodeApiImpl())),
            usersRepository:
                UsersRepositoryImpl())))
    }
}
