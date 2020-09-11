//
//  PedirCancionResponse.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

// MARK: - PedirCancionResponse
struct PedirCancionResponse: Decodable {
    let message: String
    let data: ChildPedirCancionDataResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

// MARK: - ChildPedirCancionDataResponse
struct ChildPedirCancionDataResponse: Decodable {
    let idPlaylist: Int
    let playlistSong, playlistBand, playlistRegistrationDate: JSONNull?
    let playlistStatus: Bool
    
    enum CodingKeys: String, CodingKey {
        case idPlaylist
        case playlistSong
        case playlistBand
        case playlistRegistrationDate
        case playlistStatus
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Decodable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
