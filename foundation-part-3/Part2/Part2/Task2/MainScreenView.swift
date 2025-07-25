import SwiftUI

struct MainScreenView: View {
    
    @Environment(AuthManager.self) private var auth
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome \(auth.email ?? "Guest")")
                    .font(.title)
                
                Button("Log out") {
                    auth.logout()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    NavigationStack {
        MainScreenView()
            .environment(AuthManager())
    }
}
