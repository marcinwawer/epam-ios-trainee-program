import SwiftUI
import Combine

struct Task4View: View {
    
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
            .navigationTitle("Task 4")
    }
    
    private func addSubscribers() {
        subject
            .filter { $0.isMultiple(of: 2) }
            .sink {
                print($0)
                consumedNumber = $0
            }
            .store(in: &cancellables)
    }
    
    private func sendNumbers() {
        for i in 0...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i / 2)) {
                subject.send(i)
            }
        }
    }
}

#Preview {
    NavigationStack { Task4View() }
}
