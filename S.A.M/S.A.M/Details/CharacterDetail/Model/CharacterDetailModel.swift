//
//  CharacterDetailModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 18/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct CharacterDetailModel: Codable {
    var attributionText : String
    var data : CharacterDetailDataItem
}

struct CharacterDetailDataItem: Codable {
    var characterDetail : [DetailCharacterModel]

    enum CodingKeys: String, CodingKey {
        case characterDetail = "results"
    }
}

struct DetailCharacterModel: Codable {
    let id: Int
    let name: String
    let characterDescription: String
    let imageURL: CharacterDetailThumbnail
    let urls : [CharacterUrl]
    
    enum CodingKeys: String, CodingKey {
        case id, name, urls
        case characterDescription = "description"
        case imageURL = "thumbnail"
    }
}

// MARK: - Thumbnail
struct CharacterDetailThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Thumbnail
struct CharacterUrl: Codable {
    let type: String
    let url: String
}
