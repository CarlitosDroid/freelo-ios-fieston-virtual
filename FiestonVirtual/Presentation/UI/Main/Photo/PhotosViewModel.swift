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
    
    func uploadFile(data: Data) {
        let galleryApi = GalleryApiImpl()
        galleryApi.uploadImage(
            data: data,
            idUser: 17,
            idEvent: 3,
            postType: 1,
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
    
//    func uploadVideo(fileName: String, data: URL) {
//           
//           galleryApi.uploadVideo(
//               data: data,
//               idUser: 17,
//               idEvent: 3,
//               postType: 2)
//               .subscribe(on: DispatchQueue.global())
//               .sink(receiveCompletion: { (completion: Subscribers.Completion<ExternalError>) in
//                   switch completion {
//                   case .finished:
//                       print("finish")
//                       break
//                   case .failure(let errorResponse):
//                       
//                       print("\(errorResponse.localizedDescription)")
//                       
//                       break
//                   }
//               }, receiveValue: { (eventCode: UploadImageResponse) in
//                   print("\(eventCode)")
//               })
//               .store(in: &disposables2)
//           
//       }
    
}
