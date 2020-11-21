//
//  EventsModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct EventsModel: Codable {
    var attributionText : String
    var data : EventsDataItem
}

struct EventsDataItem: Codable {
    var eventsList : [EventModel]
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case eventsList = "results"
    }
}

struct EventModel: Codable {
    let id: Int
    let title: String
    let imageURL: EventThumbnail
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "thumbnail"
    }
}

// MARK: - Thumbnail
struct EventThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
