//
//  CharactersModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 17/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct CharactersModel: Codable {
    var attributionText : String
    var data : CharacterDataItem
}

struct CharacterDataItem: Codable {
    var charactersList : [CharacterModel]
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case charactersList = "results"
    }
}

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let imageURL: CharacterThumbnail
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "thumbnail"
    }
}

// MARK: - Thumbnail
struct CharacterThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
