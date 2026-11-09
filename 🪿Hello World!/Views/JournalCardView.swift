//
//  JournalCardView.swift
//  🪿Hello World!
//
//  Created by Hanin Alfehaid on 29/05/1448 AH.
//

import SwiftUI

struct JournalCardView: View {
    let entry: JournalEntry
    var onBookmarkTap: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top) {
                Text(entry.title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.textAccent)

                Spacer()

                Button(action: onBookmarkTap) {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.textAccent)
                }
                .buttonStyle(.plain)
            }

            Text(formattedDate)
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)

            Text(entry.content)
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .lineLimit(5)
                .padding(.top, 12)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 32))
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: entry.date)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        JournalCardView(
            entry: JournalEntry(
                title: "My Birthday",
                content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.",
                date: .now,
                isBookmarked: true
            )
        )
        .padding()
    }
}
