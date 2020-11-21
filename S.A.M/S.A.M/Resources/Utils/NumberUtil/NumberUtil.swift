//
//  NumberUtil.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class NumberUtil {
    
    static func formatToCurrency(numberToFormat: Float, locale: String) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.numberStyle = .currency
        
        return formatter.string(from: numberToFormat as NSNumber) ?? ""
    }
}
