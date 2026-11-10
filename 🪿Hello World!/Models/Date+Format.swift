//
//  Date+Format.swift
//  🪿Hello World!
//
//  Created by Hanin Alfehaid on 30/05/1448 AH.
//

import Foundation

extension Date {
    private static let journalFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    var journalFormatted: String {
        Date.journalFormatter.string(from: self)
    }
}
