import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List {
                taskLink(number: 1, destination: Task1View())
            }
            .navigationTitle("Tasks")
        }
    }
    
    @ViewBuilder
    func taskLink<Destination: View>(number: Int, destination: Destination) -> some View {
        NavigationLink {
            destination
        } label: {
            Label("Task \(number)", systemImage: "\(number).circle")
        }
    }
}

#Preview {
    ContentView()
}
