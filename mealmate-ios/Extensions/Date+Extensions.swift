//
//  Date+Extensions.swift
//  mealmate-ios
//
//  Created by Maximilian Kaiser on 26.05.23.
//

import Foundation


extension Date {
    init?(fromString dateString: String, format: String = "yyyy-MM-dd") {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: dateString) {
            self = date
        } else {
            return nil
        }
    }
}
