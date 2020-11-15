//
//  SeriesInputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class SeriesInputModel {
    var title : String
    var titleStartsWith : String
    var startYear: Int
    var modifiedSince: String
    var comics: [Int]
    var stories: [Int]
    var events: [Int]
    var creators: [Int]
    var characters: [Int]
    var seriesType: String
    var contains: String
    var orderBy: String
    var limit: Int
    var offset: Int
    
    init(title: String? = "",
         titleStartsWith: String? = "",
         startYear: Int? = 0,
         modifiedSince: String? = "",
         comics: [Int]? = [],
         stories:[Int]? = [],
         events:[Int]? = [],
         creators: [Int]? = [],
         characters: [Int]? = [],
         seriesType: String? = "",
         contains: String? = "",
         orderBy: String? = "",
         limit: Int? = 20,
         offset: Int? = 0) {
        
        self.title = title!
        self.titleStartsWith = titleStartsWith!
        self.startYear = startYear!
        self.modifiedSince = modifiedSince!
        self.comics = comics!
        self.stories = stories!
        self.events = events!
        self.creators = creators!
        self.characters = characters!
        self.seriesType = seriesType!
        self.contains = contains!
        self.orderBy = orderBy!
        self.limit = limit!
        self.offset = offset!
    }
    
    func obtainParamsDict() -> [String: Any] {
        
        var params: [String: Any] = [:]
        
        if !title.isEmpty {
            params.updateValue(title, forKey: "title")
        } else if !titleStartsWith.isEmpty {
            params.updateValue(titleStartsWith, forKey: "titleStartsWith")
        } else if startYear > 0 {
            params.updateValue(startYear, forKey: "startYear")
        } else if modifiedSince.isEmpty{
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from:modifiedSince)!

            params.updateValue(date, forKey: "modifiedSince")
        } else if comics.count > 0{
            params.updateValue(comics, forKey: "comics")
        } else if stories.count > 0{
            params.updateValue(stories, forKey: "stories")
        } else if events.count > 0{
            params.updateValue(events, forKey: "events")
        } else if creators.count > 0{
            params.updateValue(creators, forKey: "creators")
        } else if characters.count > 0{
            params.updateValue(characters, forKey: "characters")
        } else if !seriesType.isEmpty{
            params.updateValue(seriesType, forKey: "seriesType")
        } else if !contains.isEmpty{
            params.updateValue(contains, forKey: "contains")
        } else if !orderBy.isEmpty{
            params.updateValue(orderBy, forKey: "orderBy")
        }
        
        params.updateValue(limit, forKey: "limit")
        params.updateValue(offset, forKey: "offset")
        
        return params
    }
}
