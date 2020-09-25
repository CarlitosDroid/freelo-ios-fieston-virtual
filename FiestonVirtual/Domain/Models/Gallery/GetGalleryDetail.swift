//
//  GetGalleryDiteilRequest.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct GetGalleryDetail: Encodable {
    let idPost: Int
    let postType: Int
    let postFile: String
    let postTitle: String
    let postStatus: Int
    let postLikeCount: Int
    let postLike: Bool
    let userName: String
    let userImage: String
}
