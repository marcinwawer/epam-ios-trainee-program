import SwiftUI
import Combine

struct Task3View: View {
    
    @State private var cancellables = Set<AnyCancellable>()
    @State private var consumedText = ""
    
    var body: some View {
        Text(consumedText)
            .font(.largeTitle)
            .bold()
            .onAppear {
                addSubscribers()
            }
            .navigationTitle("Task 3")
    }
    
    private func addSubscribers() {
        let namePublisher = Just(Constants.name)
            .map { $0.uppercased() }
        
        let surnamePublisher = Just(Constants.surname)
            .map { $0.lowercased() }
        
        namePublisher
            .combineLatest(surnamePublisher)
            .map { "\($0) \($1)" }
            .sink {
                print($0)
                consumedText = $0
            }
            .store(in: &cancellables)
    }
}

#Preview {
    NavigationStack { Task3View() }
}
