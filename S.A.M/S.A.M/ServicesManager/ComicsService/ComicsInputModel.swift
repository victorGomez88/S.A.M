//
//  ComicsInputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class ComicsInputModel {
    
    var titleStartsWith: String
    var offset: Int
    
    init(titleStartsWith: String? = "",
         offset: Int? = 0) {
        self.titleStartsWith = titleStartsWith!
        self.offset = offset!
    }
    
    func obtainParamsDict() -> [String: Any] {
        
        var params: [String: Any] = [:]
        
        if !titleStartsWith.isEmpty {
            params.updateValue(titleStartsWith, forKey: "titleStartsWith")
        }
        params.updateValue(offset, forKey: "offset")
        
        return params
    }
}
