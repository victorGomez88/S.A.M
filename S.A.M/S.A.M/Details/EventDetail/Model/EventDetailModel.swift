//
//  EventDetailModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

struct EventDetailModel: Codable {
    var attributionText : String
    var data : EventDetailDataItem
}

struct EventDetailDataItem: Codable {
    var eventDetail : [DetailEventModel]

    enum CodingKeys: String, CodingKey {
        case eventDetail = "results"
    }
}

struct DetailEventModel: Codable {
    let id: Int
    let title: String
    let eventDescription: String?
    let imageURL: EventDetailThumbnail
    let urls : [EventUrl]
    let next: NextPrevious?
    let previous: NextPrevious?
    
    enum CodingKeys: String, CodingKey {
        case id, title, urls, next, previous
        case eventDescription = "description"
        case imageURL = "thumbnail"
    }
}

// MARK: - Thumbnail
struct EventDetailThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Url
struct EventUrl: Codable {
    let type: String
    let url: String
}

// MARK: - Next and Previous
struct NextPrevious: Codable {
    let resourceURI: String
    let name: String
}

