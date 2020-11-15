//
//  StoriesInputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class StoriesInputModel {
    
    var modifiedSince: String
    var comics: [Int]
    var series: [Int]
    var events: [Int]
    var creators: [Int]
    var characters: [Int]
    var orderBy: String
    var limit: Int
    var offset: Int
    
    init(modifiedSince: String? = "",
         comics: [Int]? = [],
         series:[Int]? = [],
         events:[Int]? = [],
         creators: [Int]? = [],
         characters: [Int]? = [],
         orderBy: String? = "",
         limit: Int? = 20,
         offset: Int? = 0) {
        
        self.modifiedSince = modifiedSince!
        self.comics = comics!
        self.series = series!
        self.events = events!
        self.creators = creators!
        self.characters = characters!
        self.orderBy = orderBy!
        self.limit = limit!
        self.offset = offset!
    }
    
    func obtainParamsDict() -> [String: Any] {
        
        var params: [String: Any] = [:]
        
        if modifiedSince.isEmpty{
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from:modifiedSince)!

            params.updateValue(date, forKey: "modifiedSince")
        } else if comics.count > 0{
            params.updateValue(comics, forKey: "comics")
        } else if series.count > 0{
            params.updateValue(series, forKey: "series")
        } else if events.count > 0{
            params.updateValue(events, forKey: "events")
        } else if creators.count > 0{
            params.updateValue(creators, forKey: "creators")
        } else if characters.count > 0{
            params.updateValue(characters, forKey: "characters")
        } else if !orderBy.isEmpty{
            params.updateValue(orderBy, forKey: "orderBy")
        }
        
        params.updateValue(limit, forKey: "limit")
        params.updateValue(offset, forKey: "offset")
        
        return params
    }
}
