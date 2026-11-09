//
//  EmptyStateView.swift
//  🪿Hello World!
//
//  Created by Hanin Alfehaid on 29/05/1448 AH.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image("emptyBook")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .padding(.bottom, 16)

            Text("Begin Your Journal")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.textAccent)

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 18, weight: .light))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        EmptyStateView()
    }
}
