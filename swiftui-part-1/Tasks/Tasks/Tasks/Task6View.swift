import SwiftUI
import Combine

struct Task6View: View {
    
    @State private var cancellables = Set<AnyCancellable>()
    @State private var consumedNumber = -1
    
    private let subject = PassthroughSubject<Int, Never>()
    
    var body: some View {
        Text("\(consumedNumber)")
            .font(.largeTitle)
            .bold()
            .onAppear {
                addSubscribers()
                sendNumbers()
            }
            .navigationTitle("Task 6")
    }
    
    private func addSubscribers() {
        subject
            .flatMap { Just($0 * $0) }
            .sink {
                print($0)
                consumedNumber = $0
            }
            .store(in: &cancellables)
    }
    
    private func sendNumbers() {
        for i in 1...10 {
            subject.send(i)
        }
    }
}

#Preview {
    NavigationStack { Task6View() }
}
