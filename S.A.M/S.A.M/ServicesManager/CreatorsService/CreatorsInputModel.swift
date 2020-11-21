//
//  CreatorsInputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class CreatorsInputModel {
    var nameStartsWith : String
    var offset: Int
    
    init(nameStartsWith: String? = "",
         offset: Int? = 0) {

        self.nameStartsWith = nameStartsWith!
        self.offset = offset!
    }
    
    func obtainParamsDict() -> [String: Any] {
        
        var params: [String: Any] = [:]
        
        if !nameStartsWith.isEmpty {
            params.updateValue(nameStartsWith, forKey: "nameStartsWith")
        }
        params.updateValue(offset, forKey: "offset")
        
        return params
    }
}
