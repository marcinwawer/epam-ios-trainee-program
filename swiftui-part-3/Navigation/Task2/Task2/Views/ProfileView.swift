import SwiftUI

struct ProfileView: View {
    
    @Binding private(set) var path: [Route]
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle")
                .font(.largeTitle)
            
            Text("Profile View")
                .font(.title)
            
            Button("Go back to Home") {
                path.removeAll()
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("View #3")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ProfileView(path: .constant([]))
    }
}
