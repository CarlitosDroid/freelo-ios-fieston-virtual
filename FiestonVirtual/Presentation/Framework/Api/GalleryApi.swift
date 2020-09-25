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
    
    func uploadFile(
        data: URL,
        idUser: Int,
        idEvent: Int,
        postTitle: String
    ) -> AnyPublisher<UploadImageResponse, ExternalError>
    
    func uploadImage(
        data: Data,
        idUser: Int,
        idEvent: Int,
        postTitle: String
    ) -> AnyPublisher<UploadImageResponse, ExternalError>
    
    func getGallery(
        galleryRequest: GetGalleryRequest
    )-> AnyPublisher<GetGalleryResponse, ExternalError>

    func getGalleryDetail(
        getGalleryDetailRequest: GetGalleryDetailRequest
    ) -> AnyPublisher<GetGalleryDetailResponse, ExternalError>
    
}

