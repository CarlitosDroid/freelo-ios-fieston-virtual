//
//  ComentRemoteDataSource.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol ComentRemoteDataSource {
    func getComent(getComentRequest: GetComentRequest) ->
    AnyPublisher<Comment,ErrorResponse>
}
