import SwiftUI

struct Task2View: View {
    
    @Environment(AuthManager.self) private var auth
    
    var body: some View {
        if auth.isLoggedIn {
            MainScreenView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    NavigationStack {
        Task2View()
            .environment(AuthManager())
    }
}
