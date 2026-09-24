//
//  PhotosViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class PhotosViewModel : ObservableObject{
    
    private let uploadFileUseCase : UploadFileUseCase
    
    @Published var isLoading = false
    
    @Published var uploadPhotoMessage = ""
    @Published var uploadPhotoHasFinished = false
    
    private var disposables = Set<AnyCancellable>()
    
    init(uploadFileUseCase : UploadFileUseCase){
        self.uploadFileUseCase = uploadFileUseCase
    }
    
    func uploadFile(data: URL, postTitle: String) {
        isLoading = true
        self.uploadFileUseCase.invoke(data: data, postTitle: postTitle)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.uploadPhotoHasFinished = true
                    self.uploadPhotoMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (message: String) in
                self.uploadPhotoHasFinished = true
                self.uploadPhotoMessage = message
            })
            .store(in: &disposables)
    }
    
}
