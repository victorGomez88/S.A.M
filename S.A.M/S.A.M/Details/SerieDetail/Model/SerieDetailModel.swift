//
//  SerieDetailModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct SerieDetailModel: Codable {
    var attributionText : String
    var data : SerieDetailDataItem
}

struct SerieDetailDataItem: Codable {
    var serieDetail : [DetailSerieModel]

    enum CodingKeys: String, CodingKey {
        case serieDetail = "results"
    }
}

struct DetailSerieModel: Codable {
    let id: Int
    let title: String
    let serieDescription: String?
    let imageURL: SerieDetailThumbnail
    let urls : [SerieUrl]
    let next: NextPrevious?
    let previous: NextPrevious?
    let serieCreators: SerieCreators
    
    enum CodingKeys: String, CodingKey {
        case id, title, urls, next, previous
        case serieCreators = "creators"
        case serieDescription = "description"
        case imageURL = "thumbnail"
    }
}

// MARK: - Thumbnail
struct SerieDetailThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Url
struct SerieUrl: Codable {
    let type: String
    let url: String
}

// MARK: - Creators
struct SerieCreators: Codable {
    let count: Int
    let creators: [Creator]
    
    enum CodingKeys: String, CodingKey {
        case count = "available"
        case creators = "items"
    }
}

