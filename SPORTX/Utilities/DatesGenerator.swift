//
//  DatesGenerator.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 16/05/2025.
//

import Foundation

struct DatesGenerator {
    static func generateDates(numberOfDaysBefore: Int, numberOfDaysAfter: Int) -> (startDate: String, endDate: String) {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"

        let currentDate = Date()

        let startDate = Calendar.current.date(byAdding: .day, value: -numberOfDaysBefore, to: currentDate)!
        let endDate = Calendar.current.date(byAdding: .day, value: numberOfDaysAfter, to: currentDate)!

        let startDateString = formatter.string(from: startDate)
        let endDateString = formatter.string(from: endDate)

        return (startDateString, endDateString)
    }
}
