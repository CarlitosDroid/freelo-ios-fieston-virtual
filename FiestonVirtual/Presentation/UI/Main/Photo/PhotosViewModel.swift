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
    
    
    @Published var isLoading = false
    
    @Published var uploadPhotoMessage = ""
    @Published var uploadPhotoHasFinished = false
    
    private var disposables = Set<AnyCancellable>()
    
    func uploadFile(data: URL, postTitle: String) {
        isLoading = true
        //TODO refactor upload file
        let galleryApi = GalleryApiImpl()
        galleryApi.uploadFile(
            data: data,
            idUser: 17,
            idEvent: 3,
            postTitle: postTitle)
            .subscribe(on: DispatchQueue.global())
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ExternalError>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    print("finish")
                    break
                case .failure(let errorResponse):
                    
                    self.uploadPhotoHasFinished = true
                    self.uploadPhotoMessage = errorResponse.localizedDescription
                    
                    break
                }
            }, receiveValue: { (uploadImageResponse: UploadImageResponse) in
                print("\(uploadImageResponse)")
                self.uploadPhotoHasFinished = true
                self.uploadPhotoMessage = uploadImageResponse.message
            })
            .store(in: &disposables)
        
    }
    
}
