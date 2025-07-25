import SwiftUI

struct LoginView: View {
    
    @Environment(AuthManager.self) private var auth
    @State private var emailInput = ""
    
    var body: some View {
        NavigationStack {
            Image(systemName: "person.icloud")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundStyle(.blue)
            
            VStack {
                TextField("Email", text: $emailInput)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Pasword Placeholder (not used)", text: .constant(""))
                    .textFieldStyle(.roundedBorder)
                
                Button("Log in") {
                    auth.login(email: emailInput)
                }
                .disabled(emailInput.isEmpty)
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Login")
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environment(AuthManager())
    }
}
