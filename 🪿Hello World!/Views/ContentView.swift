import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = JournalViewModel()
    @State private var showEditor = false
    @State private var selectedEntry: JournalEntry?
    @State private var entryToDelete: JournalEntry?
    @State private var showDeleteAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundPrimary.ignoresSafeArea()

                if viewModel.entries.isEmpty {
                    EmptyStateView()
                } else if viewModel.displayedEntries.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: isSearching ? "magnifyingglass" : "bookmark")
                            .font(.system(size: 48))
                            .foregroundStyle(Color.textAccent)

                        Text(isSearching ? "No results" : "No bookmarked journals yet")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(Color.textAccent)

                        Text(isSearching
                             ? "Try a different word"
                             : "Tap the bookmark icon on a journal to save it here")
                            .font(.system(size: 18, weight: .light))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                } else {
                    List {
                        ForEach(viewModel.displayedEntries) { entry in
                            JournalCardView(entry: entry) {
                                viewModel.toggleBookmark(entry)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedEntry = entry
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    entryToDelete = entry
                                    showDeleteAlert = true
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(Color.destructive)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Journal")
            .searchable(text: $viewModel.searchText, prompt: "Search")
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
                        showEditor = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showEditor) {
                JournalEditorView(viewModel: viewModel)
            }
            .sheet(item: $selectedEntry) { entry in
                JournalEditorView(viewModel: viewModel, entry: entry)
            }
            .alert("Delete Journal?", isPresented: $showDeleteAlert, presenting: entryToDelete) { entry in
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    viewModel.delete(entry)
                }
            } message: { _ in
                Text("Are you sure you want to delete this journal?")
            }
        }
    }

    private var isSearching: Bool {
        !viewModel.searchText.isEmpty
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
