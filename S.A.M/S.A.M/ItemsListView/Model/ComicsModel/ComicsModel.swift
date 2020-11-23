//
//  ComicsModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 19/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct ComicsModel: Codable {
    var attributionText : String
    var data : ComicDataItem
}

struct ComicDataItem: Codable {
    var comicsList : [ComicModel]
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case comicsList = "results"
    }
}

struct ComicModel: Codable {
    let id: Int
    let title: String
    let format: String
    let issueNumber: Int
    let imageURL: ComicThumbnail
    
    enum CodingKeys: String, CodingKey {
        case id, title, format, issueNumber
        case imageURL = "thumbnail"
    }
}


// MARK: - Thumbnail
struct ComicThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
