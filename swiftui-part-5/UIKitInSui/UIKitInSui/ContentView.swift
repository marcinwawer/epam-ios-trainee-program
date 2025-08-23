import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("SwiftUI View")
                .font(.title)
            
            ViewControllerWrapper(make: EmbeddedViewController())
                .frame(height: 400)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
