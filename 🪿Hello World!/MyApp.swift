import SwiftUI

@main
struct MyApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                        .transition(.opacity)
                } else {
                    ContentView()
                }
            }
            .preferredColorScheme(.dark)
            .task {
                try? await Task.sleep(for: .seconds(2))
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}
