import Foundation

@MainActor
final class Counter: ObservableObject {
    
    @Published var value = 0
    
    func increment() { value += 1 }
    
    func decrement() { value -= 1 }
    
    func reset() { value = 0 }
}
