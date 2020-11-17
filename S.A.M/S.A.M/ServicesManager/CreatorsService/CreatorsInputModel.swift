//
//  CreatorsInputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class CreatorsInputModel {
    var firstName : String
    var middleName: String
    var lastName : String
    var suffix: String
    var nameStartsWith : String
    var firstNameStartsWith: String
    var middleNameStartsWith : String
    var lastNameStartsWith : String
    var modifiedSince: String
    var comics: [Int]
    var events: [Int]
    var series: [Int]
    var stories: [Int]
    var orderBy: String
    var limit: Int
    var offset: Int
    
    init(firstName: String? = "",
         middleName: String? = "",
         lastName: String? = "",
         suffix: String? = "",
         nameStartsWith: String? = "",
         firstNameStartsWith: String? = "",
         middleNameStartsWith: String? = "",
         lastNameStartsWith: String? = "",
         modifiedSince: String? = "",
         comics: [Int]? = [],
         events: [Int]? = [],
         series: [Int]? = [],
         stories:[Int]? = [],
         orderBy: String? = "",
         limit: Int? = 20,
         offset: Int? = 0) {
        
        self.firstName = firstName!
        self.middleName = middleName!
        self.lastName = lastName!
        self.suffix = suffix!
        self.nameStartsWith = nameStartsWith!
        self.firstNameStartsWith = firstNameStartsWith!
        self.middleNameStartsWith = middleNameStartsWith!
        self.lastNameStartsWith = lastNameStartsWith!
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
        
        if !firstName.isEmpty {
            params.updateValue(firstName, forKey: "firstName")
        } else if !middleName.isEmpty {
            params.updateValue(middleName, forKey: "middleName")
        } else if !lastName.isEmpty {
            params.updateValue(lastName, forKey: "lastName")
        } else if !suffix.isEmpty {
            params.updateValue(suffix, forKey: "suffix")
        } else if !nameStartsWith.isEmpty {
            params.updateValue(nameStartsWith, forKey: "nameStartsWith")
        } else if !firstNameStartsWith.isEmpty {
            params.updateValue(firstNameStartsWith, forKey: "firstNameStartsWith")
        } else if !middleNameStartsWith.isEmpty {
            params.updateValue(middleNameStartsWith, forKey: "middleNameStartsWith")
        } else if !lastNameStartsWith.isEmpty {
            params.updateValue(lastNameStartsWith, forKey: "lastNameStartsWith")
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
