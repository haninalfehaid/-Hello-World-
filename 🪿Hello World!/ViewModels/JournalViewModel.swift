import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = [] {
        didSet {
            save()
        }
    }
    @Published var searchText = ""
    @Published var sortOption: SortOption = .entryDate

    private let isPreview: Bool
    private let fileURL = URL.documentsDirectory.appending(path: "journals.json")

    init(isPreview: Bool = false) {
        self.isPreview = isPreview
        if !isPreview {
            load()
        }
    }

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

    private func save() {
        guard !isPreview else { return }
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: fileURL)
        } catch {
            print("Could not save journals: \(error)")
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let saved = try? JSONDecoder().decode([JournalEntry].self, from: data) {
            entries = saved
        }
    }
}
