//
//  CodeVerificationView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct CodeVerificationView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: UserEntity.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \UserEntity.name, ascending: true)
        ]
    ) var userEntities: FetchedResults<UserEntity>
    
    @ObservedObject var viewModel: CodeVerificationViewModel
    
    @State private var name: String = "Tim"
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            TextField("Enter your name", text: $name)
            Button(action: {
                self.viewModel.verifyCode()
            }) {
                Text("Entrar")
            }
            Button(action: {
                print(self.userEntities[0])
            }) {
                Text("Mostrar")
            }
        }
    }
    
    func addUser() {
        let userEntity = UserEntity(context: managedObjectContext)
        userEntity.name = "Carlos"
        userEntity.age = "87"
        saveContext()
    }
    
    func deleteUser() {
        
    }
   
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context \(error)")
        }
    }
}

struct CodeVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        CodeVerificationView(
            viewModel: CodeVerificationViewModel(
                loginUseCase: LoginUseCaseImpl(
                    eventCodeRepository: EventCodeRepositoryImpl(
                        eventCodeRemoteDataSource: EventCodeRemoteDataSourceImpl(
                            eventCodeApi: EventCodeApiImpl())
                    ),
                    usersRepository: UsersRepositoryImpl()
                )
            )
        )
    }
}
