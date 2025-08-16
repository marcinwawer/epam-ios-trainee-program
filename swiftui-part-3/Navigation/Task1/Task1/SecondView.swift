import SwiftUI

struct SecondView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "hand.wave")
                .font(.largeTitle)
            
            Text("Hello, SwiftUI Navigation!")
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("View #2")
    }
}

#Preview {
    NavigationStack { SecondView() }
}
