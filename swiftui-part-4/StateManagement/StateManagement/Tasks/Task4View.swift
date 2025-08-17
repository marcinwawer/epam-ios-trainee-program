import SwiftUI
import Observation

@Observable
final class User {
    
    var name: String
    var email: String
    
    init(name: String = "", email: String = "") {
        self.name = name
        self.email = email
    }
}

extension User {
    
    static func mock(name: String = "Mock Name", email: String = "Mock Email") -> User {
        .init(name: name, email: email)
    }
}


struct Task4View: View {
    
    @Bindable private var profile: User
    
    private let size: CGFloat = 150
    
    init(profile: User) {
        self.profile = profile
        print("init task view")
    }
    
    var body: some View {
        VStack(spacing: 20) {
            profileSection
                .padding(.bottom)
            
            nameSection
            emailSection
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationTitle("Task 4")
    }
}

#Preview {
    Task4View(profile: User.mock())
}

extension Task4View {
    
    private var profileSection: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .padding(.bottom)
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading) {
                Text("Name: \(profile.name)")
                Text("Email: \(profile.email)")
            }
            .font(.title2)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Label("Name", systemImage: "person")
                .padding(.leading, 4)
            
            TextField("Name", text: $profile.name, prompt: Text("Enter your name..."))
                .padding()
                .background(
                    .gray.opacity(0.2),
                    in: RoundedRectangle(cornerRadius: 10)
                )
        }
    }
    
    private var emailSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Label("Email", systemImage: "mail")
                .padding(.leading, 4)
            
            TextField("Email", text: $profile.email, prompt: Text("Enter your email..."))
                .keyboardType(.emailAddress)
                .padding()
                .background(
                    .gray.opacity(0.2),
                    in: RoundedRectangle(cornerRadius: 10)
                )
        }
    }
}
