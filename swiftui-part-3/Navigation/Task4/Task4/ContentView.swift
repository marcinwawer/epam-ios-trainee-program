import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "hand.wave")
                .font(.largeTitle)
            
            Text("Welcome!")
                .font(.title)
        }
        .navigationTitle("📱 My App")
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .toolbarBackground(.yellow, for: .navigationBar)
        .toolbar { settingsLink }
    }
}

#Preview {
    NavigationStack { ContentView() }
}

extension ContentView {
    
    private var settingsLink: some ToolbarContent {
        ToolbarItem {
            NavigationLink {
                SettingsView()
            } label: {
                Image(systemName: "gear")
            }
        }
    }
}
