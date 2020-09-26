//
//  AddComentRequest.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct AddCommentRequest: Encodable {
    let idPost: Int
    let idUserComment: Int
    let comment: String
}
