//
//  StoriesModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct StoriesModel: Codable {
    var attributionText : String
    var data : StoriesDataItem
}

struct StoriesDataItem: Codable {
    var storiesList : [StoryModel]
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case storiesList = "results"
    }
}

struct StoryModel: Codable {
    let id: Int
    let title: String
    let imageURL: StoryThumbnail
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "thumbnail"
    }
}

// MARK: - Thumbnail
struct StoryThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
