import SwiftUI
import Combine

struct Task1View: View {
    
    @State private var cancellables = Set<AnyCancellable>()
    @State private var consumedText = ""
    
    var body: some View {
        Text(consumedText)
            .font(.largeTitle)
            .bold()
            .onAppear {
                addSubscribers()
            }
            .navigationTitle("Task 1")
    }
    
    private func addSubscribers() {
        let publisher = Just(Constants.helloCombine)
        
        publisher
            .sink {
                print($0)
                consumedText = $0
            }
            .store(in: &cancellables)
    }
}

#Preview {
    NavigationStack { Task1View() }
}
