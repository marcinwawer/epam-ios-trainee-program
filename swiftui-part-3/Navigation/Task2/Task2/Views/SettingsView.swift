import SwiftUI

struct SettingsView: View {
    
    @Binding private(set) var path: [Route]
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gear")
                .font(.largeTitle)
            
            Text("Settings View")
                .font(.title)
            
            Button("Navigate to Profile") {
                path.append(.profile)
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("View #2")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView(path: .constant([]))
    }
}
