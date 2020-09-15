//
//  ComentApi.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/11/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol ComentApi {
    
    func getComentApi(idUser: Int) ->
    AnyPublisher<GetComentResponse,ExternalError>
    
    func addComent()->
    AnyPublisher<AddComentResponse,ExternalError>
}
