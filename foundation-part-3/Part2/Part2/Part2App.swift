import SwiftUI

@main
struct Part2App: App {
    
    @State private var themeManager = ThemeManager()
    @State private var authManager = AuthManager()
    @State private var searchManager = SearchManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(themeManager)
                .environment(authManager)
                .environment(searchManager)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        }
    }
}
