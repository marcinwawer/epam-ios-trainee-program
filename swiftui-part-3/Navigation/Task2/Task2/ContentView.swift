import SwiftUI

struct ContentView: View {
    
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: Route.self) { destination(for: $0) }
        }
    }
    
    @ViewBuilder
    private func destination(for route: Route) -> some View {
        switch route {
            case .settings: SettingsView(path: $path)
            case .profile: ProfileView(path: $path)
        }
    }
}

#Preview {
    ContentView()
}
