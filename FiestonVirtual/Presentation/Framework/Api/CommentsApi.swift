//
//  ComentApi.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/11/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

protocol CommentsApi {
    
    func getComments(getCommentsRequest: GetCommentsRequest) ->
    AnyPublisher<GetCommentResponse,ExternalError>
    
    func addComment(
        addCommentRequest:AddCommentRequest
    ) -> AnyPublisher<AddCommentResponse,ExternalError>
}
