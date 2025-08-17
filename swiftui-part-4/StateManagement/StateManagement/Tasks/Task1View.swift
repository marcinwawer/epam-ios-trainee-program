import SwiftUI

struct Task1View: View {
    
    @State private var counter = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(counter)")
                .font(.largeTitle)
                .bold()
                .frame(maxHeight: .infinity, alignment: .center)
            
            Button {
                counter += 1
            } label: {
                Text("+1")
                    .font(.title)
                    .padding()
                    .background(.blue, in: Circle())
                    .foregroundStyle(.white)
            }
            
            Button("Reset") {
                counter = 0
            }
        }
        .padding()
        .navigationTitle("Task 1")
    }
}

#Preview {
    NavigationStack { Task1View() }
}
