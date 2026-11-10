//
//  JournalEntry.swift
//  🪿Hello World!
//
//  Created by Hanin Alfehaid on 29/05/1448 AH.
//

import Foundation

struct JournalEntry: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool = false
}

enum SortOption {
    case bookmark
    case entryDate
}
