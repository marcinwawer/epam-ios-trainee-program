import SwiftUI

struct Task1View: View {
    
    @State private var showGreeting = false
    
    var body: some View {
        VStack {
            Toggle(
                "Show Greeting",
                systemImage: "hand.wave.fill",
                isOn: $showGreeting
            )
            
            Spacer()
            
            if showGreeting {
                Text("Hello, SwiftUI!")
                    .font(.title)
                    .bold()
                    .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .animation(.easeInOut, value: showGreeting)
        .navigationTitle("Task 1")
    }
}

#Preview {
    NavigationStack { Task1View() }
}
