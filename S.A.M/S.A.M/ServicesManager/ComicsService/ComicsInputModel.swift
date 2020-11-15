//
//  ComicsInputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class ComicsInputModel {
    
    var format : String
    var formatType: String
    var noVariants: Bool
    var dateDescriptor: String
    var dateRange: [String]
    var title: String
    var titleStartsWith: String
    var startYear: Int
    var issueNumber: Int
    var diamondCode: String
    var digitalId: Int
    var upc: String
    var isbn: String
    var ean: String
    var issn: String
    var hasDigitalIssue: Bool
    var modifiedSince: String
    var creators: [Int]
    var characters: [Int]
    var series: [Int]
    var events: [Int]
    var stories: [Int]
    var sharedAppearances: [Int]
    var collaborators: [Int]
    var orderBy: String
    var limit: Int
    var offset: Int
    
    init(format: String? = "",
         formatType: String? = "",
         noVariants: Bool? = false,
         dateDescriptor: String? = "",
         dateRange: [String]? = [],
         title: String? = "",
         titleStartsWith: String? = "",
         startYear: Int? = 0,
         issueNumber: Int? = 0,
         diamondCode: String? = "",
         digitalId: Int? = 0,
         upc: String? = "",
         isbn: String? = "",
         issn: String? = "",
         ean: String? = "",
         hasDigitalIssue: Bool? = false,
         modifiedSince: String? = "",
         creators: [Int]? = [],
         characters: [Int]? = [],
         series: [Int]? = [],
         events: [Int]? = [],
         stories:[Int]? = [],
         sharedAppearances:[Int]? = [],
         collaborators:[Int]? = [],
         orderBy: String? = "",
         limit: Int? = 20,
         offset: Int? = 0) {
        
        self.format = format!
        self.formatType = formatType!
        self.noVariants = noVariants!
        self.dateDescriptor = dateDescriptor!
        self.dateRange = dateRange!
        self.title = title!
        self.titleStartsWith = titleStartsWith!
        self.startYear = startYear!
        self.issueNumber = issueNumber!
        self.diamondCode = diamondCode!
        self.digitalId = digitalId!
        self.upc = upc!
        self.isbn = isbn!
        self.ean = ean!
        self.issn = issn!
        self.hasDigitalIssue = hasDigitalIssue!
        self.modifiedSince = modifiedSince!
        self.creators = creators!
        self.characters = characters!
        self.series = series!
        self.events = events!
        self.stories = stories!
        self.sharedAppearances = sharedAppearances!
        self.collaborators = collaborators!
        self.orderBy = orderBy!
        self.limit = limit!
        self.offset = offset!
    }
    
    func obtainParamsDict() -> [String: Any] {
        
        var params: [String: Any] = [:]
        
        if !format.isEmpty {
            params.updateValue(format, forKey: "format")
        } else if !formatType.isEmpty {
            params.updateValue(formatType, forKey: "formatType")
        } else if !dateDescriptor.isEmpty {
            params.updateValue(dateDescriptor, forKey: "dateDescriptor")
        } else if !dateRange.isEmpty {
            params.updateValue(dateRange, forKey: "dateRange")
        } else if !title.isEmpty {
            params.updateValue(title, forKey: "title")
        } else if !titleStartsWith.isEmpty {
            params.updateValue(titleStartsWith, forKey: "titleStartsWith")
        } else if startYear > 0 {
            params.updateValue(startYear, forKey: "startYear")
        } else if issueNumber > 0 {
            params.updateValue(issueNumber, forKey: "issueNumber")
        } else if !diamondCode.isEmpty {
            params.updateValue(diamondCode, forKey: "diamondCode")
        } else if digitalId > 0 {
            params.updateValue(digitalId, forKey: "digitalId")
        } else if !upc.isEmpty {
            params.updateValue(upc, forKey: "upc")
        } else if !isbn.isEmpty {
            params.updateValue(isbn, forKey: "isbn")
        } else if !ean.isEmpty {
            params.updateValue(ean, forKey: "ean")
        } else if !issn.isEmpty {
            params.updateValue(issn, forKey: "issn")
        } else if !isbn.isEmpty {
            params.updateValue(isbn, forKey: "isbn")
        } else if !isbn.isEmpty {
            params.updateValue(isbn, forKey: "isbn")
        } else if !isbn.isEmpty {
            params.updateValue(isbn, forKey: "isbn")
        } else if !isbn.isEmpty {
            params.updateValue(isbn, forKey: "isbn")
        } else if !isbn.isEmpty {
            params.updateValue(isbn, forKey: "isbn")
        } else if modifiedSince.isEmpty{
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from:modifiedSince)!

            params.updateValue(date, forKey: "modifiedSince")
        } else if creators.count > 0{
            params.updateValue(creators, forKey: "creators")
        } else if characters.count > 0{
            params.updateValue(characters, forKey: "characters")
        } else if series.count > 0{
            params.updateValue(series, forKey: "series")
        } else if events.count > 0{
            params.updateValue(events, forKey: "events")
        } else if stories.count > 0{
            params.updateValue(stories, forKey: "stories")
        } else if sharedAppearances.count > 0{
            params.updateValue(sharedAppearances, forKey: "sharedAppearances")
        } else if collaborators.count > 0{
            params.updateValue(collaborators, forKey: "collaborators")
        } else if !orderBy.isEmpty{
            params.updateValue(orderBy, forKey: "orderBy")
        }
        
        params.updateValue(noVariants, forKey: "noVariants")
        params.updateValue(hasDigitalIssue, forKey: "hasDigitalIssue")
        params.updateValue(limit, forKey: "limit")
        params.updateValue(offset, forKey: "offset")
        
        return params
    }
}
