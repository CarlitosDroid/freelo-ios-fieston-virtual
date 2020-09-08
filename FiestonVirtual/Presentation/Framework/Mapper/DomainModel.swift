//
//  DomainModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

protocol DomainModel {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}
