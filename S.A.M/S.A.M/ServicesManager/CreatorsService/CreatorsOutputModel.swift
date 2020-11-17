//
//  CreatorsOutputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

// MARK: - CreatorsOutputModel
struct CreatorsOutputModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: CreatorsDataClass
}

// MARK: - CreatorsDataClass
struct CreatorsDataClass: Codable {
    let offset, limit, total, count: Int
    let creatorsList: [CreatorsResult]
    
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case creatorsList = "results"
    }
}

// MARK: - CreatorsResult
struct CreatorsResult: Codable {
    let id: Int
    let firstName, middleName, lastName, suffix: String
    let fullName: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: String
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
