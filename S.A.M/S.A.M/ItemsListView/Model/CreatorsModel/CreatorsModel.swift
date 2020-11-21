//
//  CreatorsModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct CreatorsModel: Codable {
    var attributionText : String
    var data : CreatorsDataItem
}

struct CreatorsDataItem: Codable {
    var creatorsList : [CreatorModel]
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case creatorsList = "results"
    }
}

struct CreatorModel: Codable {
    let id: Int
    let fullName: String
    let imageURL: CreatorThumbnail
    let urls: [CreatorUrl]
    
    enum CodingKeys: String, CodingKey {
        case id, fullName, urls
        case imageURL = "thumbnail"
    }
}

// MARK: - Thumbnail
struct CreatorThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLs
struct CreatorUrl: Codable {
    let type: String
    let url: String
}
