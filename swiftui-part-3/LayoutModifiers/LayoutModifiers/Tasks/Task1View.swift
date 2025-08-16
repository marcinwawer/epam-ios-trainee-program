import SwiftUI

struct Task1View: View {
    
    var body: some View {
        VStack {
            Text(Constants.modifiersText)
                .font(.title3)
                .padding(16)
                .padding(.vertical, 20)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding([.leading, .top], 10)
                .padding([.trailing, .bottom], 10)
                .background(.blue)
                .foregroundStyle(.white)
        }
        .navigationTitle("Task 1")
    }
}

#Preview {
    NavigationStack { Task1View() }
}
