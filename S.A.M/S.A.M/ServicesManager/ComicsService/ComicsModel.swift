//
//  ComicsModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
// MARK: - ComicsModel
struct ComicsModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: ComicsDataClass
}

// MARK: - DataClass
struct ComicsDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [ComicsResult]
}

// MARK: - Result
struct ComicsResult: Codable {
    let id, digitalId: Int
    let title: String
    let issueNumber: Int
    let variantDescription: String
    let resultDescription: String?
    let modified: String
    let isbn, upc, diamondCode, ean: String
    let issn, format: String
    let pageCount: Int
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: SeriesItem
    let variants: [ComicsItem]
    let collections: [ComicsItem]
    let collectedIssues: [ComicsItem]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let events: Events

    enum CodingKeys: String, CodingKey {
        case id
        case digitalId
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharactersItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CharactersItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

// MARK: - DateElement
struct DateElement: Codable {
    let type, date: String
}


// MARK: - Price
struct Price: Codable {
    let type: String
    let price: Double
}

// MARK: - TextObject
struct TextObject: Codable {
    let type, language, text: String
}
