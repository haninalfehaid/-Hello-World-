import SwiftUI

struct JournalEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: JournalViewModel
    var entry: JournalEntry? = nil

    @State private var title = ""
    @State private var content = ""
    @State private var showDiscardDialog = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                TextField("Title", text: $title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)

                Text(formattedDate)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.textSecondary)

                ZStack(alignment: .topLeading) {
                    if content.isEmpty {
                        Text("Type your Journal...")
                            .foregroundStyle(Color.textSecondary)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }
                    TextEditor(text: $content)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.white)
                }
                .font(.system(size: 18))
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.cardSurface)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        if hasChanges {
                            showDiscardDialog = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .confirmationDialog(
                        "Are you sure you want to discard changes on this journal?",
                        isPresented: $showDiscardDialog,
                        titleVisibility: .visible
                    ) {
                        Button("Discard Changes", role: .destructive) {
                            dismiss()
                        }
                        Button("Keep Editing") { }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        save()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.glassProminent)
                    .disabled(title.isEmpty)
                }
            }
            .interactiveDismissDisabled(hasChanges)
            .onAppear {
                if let entry {
                    title = entry.title
                    content = entry.content
                }
            }
        }
    }

    private var hasChanges: Bool {
        if let entry {
            return title != entry.title || content != entry.content
        } else {
            return !title.isEmpty || !content.isEmpty
        }
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: entry?.date ?? .now)
    }

    private func save() {
        if var entry {
            entry.title = title
            entry.content = content
            viewModel.update(entry)
        } else {
            viewModel.add(title: title, content: content)
        }
        dismiss()
    }
}

#Preview {
    JournalEditorView(viewModel: JournalViewModel())
        .preferredColorScheme(.dark)
}
