//
//  UploadImageResponseMapper.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

extension UploadImageProfileResponse: DomainModel {
    
    typealias DomainModelType = ProfileImage
    
    func toDomainModel() -> ProfileImage {
        return ProfileImage(imageUrl: self.data.post.postFile)
    }

}
