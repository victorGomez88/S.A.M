//
//  EventsOutputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

// MARK: - EventsOutputModel
struct EventsOutputModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: EventsDataClass
}

// MARK: - EventsDataClass
struct EventsDataClass: Codable {
    let offset, limit, total, count: Int
    let eventsList: [EventsResult]
    
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case eventsList = "results"
    }
}

// MARK: - EventsResult
struct EventsResult: Codable {
    let id: Int
    let title, resultDescription: String
    let resourceURI: String
    let urls: String
    let modified: String
    let start, end: String?
    let thumbnail: Thumbnail
    let creators: Creators
    let characters: CharactersModel
    let stories: Stories
    let comics: Comics
    let series: Series
    let next: Next?
    let previous: Previous?

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, urls, modified, start, end, thumbnail, creators, characters, stories, comics, series, next, previous
    }
}

// MARK: - Events
struct Events: Codable {
    let available: Int
    let collectionURI: String
    let items: [EventsItem]
    let returned: Int
}

// MARK: - SeriesItem
struct EventsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Next
struct Next: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Next
struct Previous: Codable {
    let resourceURI: String
    let name: String
}
