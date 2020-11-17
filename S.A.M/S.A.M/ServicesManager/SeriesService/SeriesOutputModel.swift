//
//  SeriesOutputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

// MARK: - SeriesOutputModel
struct SeriesOutputModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: SeriesDataClass
}

// MARK: - DataClass
struct SeriesDataClass: Codable {
    let offset, limit, total, count: Int
    let seriesList: [SeriesResult]
    
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case seriesList = "results"
    }
}

// MARK: - Result
struct SeriesResult: Codable {
    let id: Int
    let title: String
    let resultDescription: String?
    let resourceURI: String
    let urls: [URLElement]
    let startYear, endYear: Int
    let rating, type: String
    let modified: String
    let thumbnail: Thumbnail
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let comics: Comics
    let events: Events
    let next: Next?
    let previous: Previous?

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, urls, startYear, endYear, rating, type, modified, thumbnail, creators, characters, stories, comics, events, next, previous
    }
}


// MARK: - Series
struct Series: Codable {
    let available: Int
    let collectionURI: String
    let items: [SeriesItem]
    let returned: Int
}

// MARK: - SeriesItem
struct SeriesItem: Codable {
    let resourceURI: String
    let name: String
}
