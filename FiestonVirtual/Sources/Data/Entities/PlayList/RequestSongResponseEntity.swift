//
//  PedirCancionResponse.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct RequestSongResponseEntity : Decodable {
    let message: String
    let data: ChildRequestSongResponseEntity
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

struct ChildRequestSongResponseEntity : Decodable {
    let idPlaylist: Int
    let playlistSong, playlistBand, playlistRegistrationDate: String
    let playlistStatus: Bool
    let playListURL: String?
    
    enum CodingKeys: String, CodingKey {
        case idPlaylist
        case playlistSong
        case playlistBand
        case playlistRegistrationDate
        case playlistStatus
        case playListURL
    }
}
