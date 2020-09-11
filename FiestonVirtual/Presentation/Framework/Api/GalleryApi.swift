//
//  GalleryDataSource.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol GalleryApi {
    
    func uploadImage(
        data: Data,
        idUser: Int,
        idEvent: Int,
        postType: Int,
        postTitle: String
    ) -> AnyPublisher<UploadImageResponse, ExternalError>

//    func uploadVideo(
//        data: URL,
//        idUser: Int,
//        idEvent: Int,
//        postType: Int
//    ) -> AnyPublisher<UploadImageResponse, ExternalError>
//    
}

