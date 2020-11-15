//
//  CharacterModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

// MARK: - CharactersOutputModel
struct CharactersOutputModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: CharactersDataClass
}

// MARK: - CharactersDataClass
struct CharactersDataClass: Codable {
    let offset, limit, total, count: Int
    let characterList: [CharactersResult]
    
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case characterList = "results"
    }
}

// MARK: - CharactersResult
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

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharactersItem]
    let returned: Int
}

// MARK: - CharactersItem
struct CharactersItem: Codable {
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
