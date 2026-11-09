//
//  SplashView.swift
//  🪿Hello World!
//
//  Created by Hanin Alfehaid on 29/05/1448 AH.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.black, Color.cardSurface],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 8) {
                Image("notebook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)

                Text("Journali")
                    .font(.system(size: 42, weight: .black))
                    .foregroundStyle(.white)

                Text("Your thoughts, your story")
                    .font(.system(size: 18, weight: .light))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    SplashView()
}
