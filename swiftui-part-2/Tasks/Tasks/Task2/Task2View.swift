import SwiftUI

struct Task2View: View {
    
    private let names = ["Marcin", "John", "Mary", "Alice", "Jane"]
    
    var body: some View {
        List(names, id: \.self) {name in
            HStack {
                Text(name)
                
                Spacer()
                
                Button("Tap") {
                    buttonAction(for: name)
                }
            }
        }
        .navigationTitle("Task 2")
    }
    
    private func buttonAction(for name: String) {
        print(name)
    }
}

#Preview {
    NavigationStack { Task2View() }
}
