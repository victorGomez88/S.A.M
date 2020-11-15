//
//  CharacterModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

// MARK: - CharactersModel
struct CharactersModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: CharactersDataClass
}

// MARK: - DataClass
struct CharactersDataClass: Codable {
    let offset, limit, total, count: Int
    let characterList: [CharactersResult]
    
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case characterList = "results"
    }
}

// MARK: - Result
struct CharactersResult: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics: Comics
    let series: Series
    let stories: Stories
    let events: Events
    let urls: [URLElement]

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
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


// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}
