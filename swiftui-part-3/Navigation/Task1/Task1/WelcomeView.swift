import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "hand.thumbsup")
                .font(.largeTitle)
            
            Text("Welcome!")
                .font(.title)
            
            NavigationLink(destination: SecondView()) {
                Text("Navigate")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .foregroundStyle(.white)
                    .background(.blue, in: Capsule())
            }
        }
        .navigationTitle("View #1")
    }
}

#Preview {
    NavigationStack { WelcomeView() }
}
