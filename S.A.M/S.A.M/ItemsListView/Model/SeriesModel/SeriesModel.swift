//
//  SeriesModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct SeriesModel: Codable {
    var attributionText : String
    var data : SeriesDataItem
}

struct SeriesDataItem: Codable {
    var seriesList : [SerieModel]
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case seriesList = "results"
    }
}

struct SerieModel: Codable {
    let id: Int
    let title: String
    let imageURL: SerieThumbnail
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "thumbnail"
    }
}

// MARK: - Thumbnail
struct SerieThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
