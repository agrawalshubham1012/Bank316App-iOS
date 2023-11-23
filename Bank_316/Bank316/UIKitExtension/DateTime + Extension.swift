//
//  DateTime + Extension.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 09/11/23.
//

import Foundation
import UIKit

extension Date {
    func categorizedDateString() -> String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!

        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM. yyyy"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter.string(from: self)
        }
    }
}
