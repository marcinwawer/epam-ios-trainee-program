import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List {
              taskLink(number: 1, destination: Task1View())
              taskLink(number: 2, destination: Task2View())
              taskLink(number: 3, destination: Task3View())
              taskLink(number: 4, destination: Task4View())
              taskLink(number: 5, destination: Task5View())
              taskLink(number: 6, destination: Task6View())
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
