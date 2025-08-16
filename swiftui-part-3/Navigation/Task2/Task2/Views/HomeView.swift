import SwiftUI

struct HomeView: View {
    
    @Binding private(set) var path: [Route]
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "house")
                .font(.largeTitle)
            
            Text("Home View")
                .font(.title)
            
            Button("Navigate to Settings") {
                path.append(.settings)
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("View #1")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HomeView(path: .constant([]))
    }
}
