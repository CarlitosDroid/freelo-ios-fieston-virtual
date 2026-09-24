//
//  ComentResponseMapper.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

extension GetCommentResponse: DomainModel {
    
    typealias DomainModelType = [Comment]

    func toDomainModel() -> [Comment] {
        return self.data.comments.map { (childComentResponse: ChildGetCommentsResponse) -> Comment in
            Comment(id: childComentResponse.idComment,
                   text: childComentResponse.comment,
                   avatar: childComentResponse.avatar,
                   userName: childComentResponse.userComment)
    }
}
}
