import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Welcome!")
                .font(.largeTitle)
            
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
