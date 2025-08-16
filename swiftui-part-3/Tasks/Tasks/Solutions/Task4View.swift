import SwiftUI

struct Task4View: View {
    
    private let size: CGFloat = 100
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color.yellow
            
            Circle()
                .frame(width: size, height: size)
                .foregroundStyle(.blue)
                .offset(x: -(screenWidth / 2.5), y: -(screenHeight / 2.5))
            
            Rectangle()
                .frame(width: size * 1.5, height: size)
                .foregroundStyle(.red)
                .offset(x: -(screenWidth / 4), y: -(screenHeight / 4))
        }
        .padding()
        .navigationTitle("Task 4")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { Task4View() }
}
