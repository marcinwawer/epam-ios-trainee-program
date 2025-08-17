import SwiftUI

struct Task3View: View {
    
    @State private var flag = false
    
    private let size: CGFloat = 150
    
    var body: some View {
        VStack(spacing: 20) {
            Task3ChildView(flag: $flag)
            
            Spacer()
            
            Image(systemName: flag ? "wifi" : "wifi.slash")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(flag ? .blue : .red)
                .contentTransition(.symbolEffect(.replace))
                .symbolEffect(.bounce, value: flag)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Task 3")
    }
}

struct Task3ChildView: View {
    
    @Binding private(set) var flag: Bool
    
    var body: some View {
        Toggle(
            "Change State",
            systemImage: "paperplane",
            isOn: $flag
        )
    }
}

#Preview {
    NavigationStack { Task3View() }
}
