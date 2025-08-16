import SwiftUI

struct CustomButtonStyle: ViewModifier {
    
    private(set) var isEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .fill(isEnabled ? .blue : .gray)
            )
            .opacity(isEnabled ? 1.0 : 0.5)
    }
}

struct Task6View: View {
    
    @State private var isEnabled = true
    @State private var counter = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button") {
                counter += 1
            }
            .modifier(CustomButtonStyle(isEnabled: isEnabled))
            .disabled(!isEnabled)
            
            Text("Button tapped \(counter) times")
                .font(.title2)
            
            Toggle("Enable Button", isOn: $isEnabled)
                .padding()
        }
        .navigationTitle("Task 6")
    }
}

#Preview {
    NavigationStack { Task6View() }
}
