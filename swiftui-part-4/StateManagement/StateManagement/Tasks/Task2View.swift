import SwiftUI

struct Task2View: View {
    
    @State private var showLabel = true
    
    var body: some View {
        VStack(spacing: 20) {
            Toggle(
                "Show Label",
                systemImage: "pencil.circle",
                isOn: $showLabel
            )
            
            Spacer()
            
            if showLabel {
                Text("Hello, SwiftUI!")
                    .font(.title)
                    .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .animation(.easeInOut, value: showLabel)
        .navigationTitle("Task 2")
    }
}

#Preview {
    NavigationStack { Task2View() }
}
