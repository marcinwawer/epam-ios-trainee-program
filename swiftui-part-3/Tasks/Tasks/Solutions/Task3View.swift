import SwiftUI

struct Task3View: View {
    
    private let size: CGFloat = 300
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        .font(.headline)
        .padding()
        .foregroundStyle(.white)
        .background(.blue)
        .navigationTitle("Task 3")
    }
}

#Preview {
    NavigationStack { Task3View() }
}

