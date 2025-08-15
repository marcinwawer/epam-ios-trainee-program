import SwiftUI
import Combine

struct Task2View: View {
    
    @State private var cancellables = Set<AnyCancellable>()
    @State private var consumedText = ""
    
    var body: some View {
        Text(consumedText)
            .font(.largeTitle)
            .bold()
            .onAppear {
                addSubscribers()
            }
            .navigationTitle("Task 2")
    }
    
    private func addSubscribers() {
        let futurePublisher = Future<String, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(.success(Constants.helloCombine))
            }
        }
        
        futurePublisher
            .sink {
                print($0)
                consumedText = $0
            }
            .store(in: &cancellables)
    }
}

#Preview {
    NavigationStack { Task2View() }
}

