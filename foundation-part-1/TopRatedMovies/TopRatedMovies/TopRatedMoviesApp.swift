import SwiftUI

@main
struct TopRatedMoviesApp: App {
    
    var body: some Scene {
        WindowGroup {
            TopRatedSeriesView()
                .task {
                    do {
                        try await KeyConstants.loadAPIKeys()
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                }
        }
    }
}
