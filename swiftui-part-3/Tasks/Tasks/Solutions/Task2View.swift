import SwiftUI

struct Task2View: View {
    
    private let width: CGFloat = 150
    private let height: CGFloat = 100
    
    var body: some View {
        ZStack {
            Color.yellow
            
            Rectangle()
                .fill(.red)
                .frame(width: width, height: height, alignment: .center)
            
            Rectangle()
                .fill(.blue)
                .frame(width: width, height: height)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .navigationTitle("Task 2")
        .padding(8)
    }
}

#Preview {
    NavigationStack { Task2View() }
}
