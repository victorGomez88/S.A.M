//
//  File.swift
//  S.A.M
//
//  Created by Victor Gomez on 21/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class DateUtil {
    
    static func formatDate(date: String, formatInput: String, formatOutput: String) -> String {

        let formatterInputDate = DateFormatter()
        formatterInputDate.locale = Locale(identifier: "en_US_POSIX")
        formatterInputDate.dateFormat = formatInput

        let formatterOutputDate = DateFormatter()
        formatterOutputDate.locale = Locale(identifier: "en_US")
        formatterOutputDate.dateFormat = formatOutput

        if let date = formatterInputDate.date(from: date) {
            return formatterOutputDate.string(from: date)
        } else {
           print("Error to format date")
           return ""
        }
    }
}
