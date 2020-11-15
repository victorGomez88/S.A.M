//
//  StoriesOutputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

// MARK: - StoriesOutputModel
struct StoriesOutputModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: StoriesDataClass
}

// MARK: - StoriesDataClass
struct StoriesDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [StoriesResult]
}

// MARK: - StoriesResult
struct StoriesResult: Codable {
    let id: Int
    let title, resultDescription: String
    let resourceURI: String
    let type: String
    let modified: Date
    let thumbnail: Thumbnail
    let creators: Creators
    let characters: Characters
    let series: Series
    let comics: Comics
    let events: Events
    let originalIssue: OriginalIssue

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription
        case resourceURI, type, modified, thumbnail, creators, characters, series, comics, events, originalIssue
    }
}

// MARK: - OriginalIssue
struct OriginalIssue: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
    
    enum CodingKeys: String, CodingKey {
        case available, collectionURI, items, returned
    }
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case resourceURI, name, type
    }
}
