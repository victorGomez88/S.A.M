//
//  ComicsModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
// MARK: - ComicsOutputModel
struct ComicsOutputModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: ComicsDataClass
}

// MARK: - ComicsDataClass
struct ComicsDataClass: Codable {
    let offset, limit, total, count: Int
    let comicsList: [ComicsResult]
    
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case comicsList = "results"
    }
}

// MARK: - ComicsResult
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
    let urls: String
    let series: SeriesItem
    let variants: [ComicsItem]
    let collections: [ComicsItem]
    let collectedIssues: [ComicsItem]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: Creators
    let characters: CharactersModel
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
