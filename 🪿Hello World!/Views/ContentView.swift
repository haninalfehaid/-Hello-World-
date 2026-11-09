import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = JournalViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundPrimary.ignoresSafeArea()

                if viewModel.entries.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(viewModel.displayedEntries) { entry in
                            JournalCardView(entry: entry) {
                                viewModel.toggleBookmark(entry)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu {
                        Button("Sort by Bookmark") {
                            viewModel.sortOption = .bookmark
                        }
                        Button("Sort by Entry Date") {
                            viewModel.sortOption = .entryDate
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }

                    Button {
                        // بنربطه بشاشة الإضافة في اليوم الخامس
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview("Empty") {
    ContentView()
        .preferredColorScheme(.dark)
}

#Preview("With Entries") {
    let viewModel = JournalViewModel()
    viewModel.add(title: "My Birthday", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.")
    viewModel.add(title: "Today's Journal", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.")
    viewModel.add(title: "Great Day", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.")
    return ContentView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
