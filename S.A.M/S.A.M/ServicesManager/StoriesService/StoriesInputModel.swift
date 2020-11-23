//
//  StoriesInputModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 15/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class StoriesInputModel {

    var offset: Int
    
    init(offset: Int? = 0) {
        self.offset = offset!
    }
    
    func obtainParamsDict() -> [String: Any] {
        
        var params: [String: Any] = [:]
        params.updateValue(offset, forKey: "offset")
        
        return params
    }
}
