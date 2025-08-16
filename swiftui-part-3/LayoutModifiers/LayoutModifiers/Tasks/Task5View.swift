import SwiftUI

struct Task5View: View {
    
    private let size: CGFloat = 100
    
    var body: some View {
        ZStack {
            Text(Constants.amazingText)
                .font(.title3)
                .bold()
                .background(.gray, in: Rectangle())
                .fixedSize(horizontal: true, vertical: false)
                .overlay {
                    Circle()
                        .frame(width: size, height: size)
                        .foregroundStyle(.blue).opacity(0.3)
                }
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
        .navigationTitle("Task 5")
    }
}

#Preview {
    NavigationStack { Task5View() }
}
