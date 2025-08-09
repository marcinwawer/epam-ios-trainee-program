import SwiftUI

struct Task7View: View {
    
    var body: some View {
        ScrollView {
            UserDetailsView(user: .init(name: "John Surname", age: 29, location: "Poland", isPremium: false))
            
            UserDetailsView(user: .init(name: "Jane Longsurname", age: 31, location: "Poland", isPremium: true))
        }
    }
}

#Preview {
    NavigationStack {
        Task7View()
    }
}

struct User {
    
    let name: String
    let age: Int
    let location: String
    let isPremium: Bool
}

struct UserDetailsView: View {
    
    let user: User
    private let photoSize: CGFloat = 100
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if user.isPremium {
                Label("Premium", systemImage: "star.fill")
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
            }
            
            HStack {
                placeholderImage
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.title2)
                    
                    Group {
                        Label("\(user.age)", systemImage: "calendar")
                        Label("\(user.location)", systemImage: "mappin.and.ellipse")
                    }
                    .font(.headline)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(user.isPremium ? .yellow : .gray)
        }
        .padding(.horizontal)
        .navigationTitle("Task 7")
    }
}

extension UserDetailsView {
    
    private var placeholderImage: some View {
        ProgressView()
            .frame(width: photoSize, height: photoSize)
            .background(.secondary.opacity(0.4))
            .clipShape(Circle())
    }
}
