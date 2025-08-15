import SwiftUI
import Combine

struct Task5View: View {
    
    @State private var cancellables = Set<AnyCancellable>()
    @State private var consumedText = "_"
    
    private let subject = PassthroughSubject<String, Never>()
    
    var body: some View {
        Text(consumedText)
            .font(.largeTitle)
            .bold()
            .onAppear {
                addSubscribers()
                simulateTyping()
            }
            .navigationTitle("Task 5")
    }
    
    private func addSubscribers() {
        subject
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink {
                print($0)
                consumedText = $0
            }
            .store(in: &cancellables)
    }
    
    private func simulateTyping() {
        let terms = ["H", "He", "Hel", "Hello"]
        for term in terms {
            subject.send(term)
        }
    }
}

#Preview {
    NavigationStack { Task5View() }
}
