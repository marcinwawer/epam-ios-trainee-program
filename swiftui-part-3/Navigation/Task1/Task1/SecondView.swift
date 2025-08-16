import SwiftUI

struct SecondView: View {
    
    var body: some View {
        VStack {
            Text("Hello, SwiftUI Navigation!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("View #2")
    }
}

#Preview {
    NavigationStack { SecondView() }
}
