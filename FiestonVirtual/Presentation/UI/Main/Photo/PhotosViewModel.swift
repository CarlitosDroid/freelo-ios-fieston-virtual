//
//  PhotosViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class PhotosViewModel {
    
    private var disposables = Set<AnyCancellable>()
    
    func uploadFile(data: URL) {
        let galleryApi = GalleryApiImpl()
        galleryApi.uploadFile(
            data: data,
            idUser: 17,
            idEvent: 3,
     
            postTitle: "Excelente Foto!!!!!")
            .subscribe(on: DispatchQueue.global())
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ExternalError>) in
                switch completion {
                case .finished:
                    print("finish")
                    break
                case .failure(let errorResponse):
                    
                    print("\(errorResponse.localizedDescription)")
                    
                    break
                }
            }, receiveValue: { (uploadImageResponse: UploadImageResponse) in
                print("\(uploadImageResponse)")
            })
            .store(in: &disposables)
        
    }
    
}
