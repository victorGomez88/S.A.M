//
//  CharactersInputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class CharactersInputModel {
    
    var name : String
    var nameStartsWith: String
    var modifiedSince: String
    var comics: [Int]
    var events: [Int]
    var series: [Int]
    var stories: [Int]
    var orderBy: String
    var limit: Int
    var offset: Int
    
    init(name: String? = "",
         nameStartsWith: String? = "",
         modifiedSince: String? = "",
         comics: [Int]? = [],
         events: [Int]? = [],
         series: [Int]? = [],
         stories:[Int]? = [],
         orderBy: String? = "",
         limit: Int? = 20,
         offset: Int? = 0) {
        
        self.name = name!
        self.nameStartsWith = nameStartsWith!
        self.modifiedSince = modifiedSince!
        self.comics = comics!
        self.events = events!
        self.series = series!
        self.stories = stories!
        self.orderBy = orderBy!
        self.limit = limit!
        self.offset = offset!
    }
    
    func obtainParamsDict() -> [String: Any] {
        
        var params: [String: Any] = [:]
        
        if !name.isEmpty {
            params.updateValue(name, forKey: "name")
        } else if !nameStartsWith.isEmpty {
            params.updateValue(nameStartsWith, forKey: "nameStartsWith")
        } else if modifiedSince.isEmpty{
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from:modifiedSince) {
                params.updateValue(date, forKey: "modifiedSince")
            }
        } else if comics.count > 0{
            params.updateValue(comics, forKey: "comics")
        } else if events.count > 0{
            params.updateValue(events, forKey: "events")
        } else if series.count > 0{
            params.updateValue(series, forKey: "series")
        } else if stories.count > 0{
            params.updateValue(stories, forKey: "stories")
        } else if !orderBy.isEmpty{
            params.updateValue(orderBy, forKey: "orderBy")
        }
        
        params.updateValue(limit, forKey: "limit")
        params.updateValue(offset, forKey: "offset")
        
        return params
    }
}
