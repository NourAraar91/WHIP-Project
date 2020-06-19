//
//  UIString+Date+Ext.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import Foundation


private let DateFormat = "yyyy-MM-dd"

private let dateFormatterUnlocalized: DateFormatter = {
    let dateFormatterUnlocalized = DateFormatter()
    let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
    dateFormatterUnlocalized.locale = enUSPOSIXLocale
    return dateFormatterUnlocalized
}()

private let dateFormatterLocalized: DateFormatter = {
    let dateFormatterLocalized = DateFormatter()
    return dateFormatterLocalized
}()

extension String {

    var date: Date? {
        var result: Date?

        dateFormatterUnlocalized.dateFormat = DateFormat
        result = dateFormatterUnlocalized.date(from: self)
        return result
    }
}
