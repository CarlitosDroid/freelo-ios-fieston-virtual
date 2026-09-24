//
//  UploadProfileImageUseCase.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol UploadProfileImageUseCase {
    func invoke(imageProfileURL: URL) -> AnyPublisher<ProfileImage, ErrorResponse>
}
