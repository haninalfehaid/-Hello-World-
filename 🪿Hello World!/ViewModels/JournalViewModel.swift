//
//  JournalViewModel.swift
//  🪿Hello World!
//
//  Created by Hanin Alfehaid on 29/05/1448 AH.
//

import Foundation
import SwiftUI
import Combine
class JournalViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []
    @Published var searchText = ""
    @Published var sortOption: SortOption = .entryDate

    var displayedEntries: [JournalEntry] {
        var result = entries

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {
        case .bookmark:
            result = result.filter { $0.isBookmarked }
        case .entryDate:
            result.sort { $0.date > $1.date }
        }
        return result
    }

    func add(title: String, content: String) {
        entries.append(JournalEntry(title: title, content: content, date: .now))
    }

    func update(_ entry: JournalEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
        }
    }

    func delete(_ entry: JournalEntry) {
        entries.removeAll { $0.id == entry.id }
    }

    func toggleBookmark(_ entry: JournalEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index].isBookmarked.toggle()
        }
    }
}
