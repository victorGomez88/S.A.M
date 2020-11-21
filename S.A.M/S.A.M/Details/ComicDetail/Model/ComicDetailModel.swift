//
//  ComicDetailModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct ComicDetailModel: Codable {
    var attributionText : String
    var data : ComicDetailDataItem
}

struct ComicDetailDataItem: Codable {
    var comicDetail : [DetailComicModel]

    enum CodingKeys: String, CodingKey {
        case comicDetail = "results"
    }
}

struct DetailComicModel: Codable {
    let id: Int
    let title: String
    let issueNumber: Int
    let pageCount: Int
    let format: String
    let comicDescription: String?
    let dates: [ComicDate]
    let prices: [ComicPrice]
    let imageURL: ComicDetailThumbnail
    let urls : [ComicUrl]
    let comicCreators: ComicCreators
    
    enum CodingKeys: String, CodingKey {
        case id, title, urls, issueNumber, pageCount, format, dates, prices
        case comicCreators = "creators"
        case comicDescription = "description"
        case imageURL = "thumbnail"
    }
}

// MARK: - PRICE
struct ComicPrice: Codable {
    let type: String
    let price: Float
}

// MARK: - DATES
struct ComicDate: Codable {
    let type, date: String
}

// MARK: - Thumbnail
struct ComicDetailThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Url
struct ComicUrl: Codable {
    let type: String
    let url: String
}

// MARK: - Creators
struct ComicCreators: Codable {
    let count: Int
    let creators: [Creator]
    
    enum CodingKeys: String, CodingKey {
        case count = "available"
        case creators = "items"
    }
}

struct Creator: Codable {
    let name, role: String
}
