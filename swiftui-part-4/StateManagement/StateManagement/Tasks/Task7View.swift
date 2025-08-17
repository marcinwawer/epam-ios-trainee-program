import SwiftUI

@Observable @MainActor
final class Counter {
    
    private(set) var value = 0
    
    func increment() {
        value += 1
    }
}

struct Task7View: View {
    
    @State private var counter = Counter()
    
    var body: some View {
        VStack {
            ChildView(counter: counter, viewType: .a)
            Divider()
            ChildView(counter: counter, viewType: .b)
        }
        .navigationTitle("Task 7")
    }
}

struct ChildView: View {
    
    enum ViewType: String {
        case a = "A"
        case b = "B"
    }
    
    private let counter: Counter
    private let viewType: ViewType
    
    init(counter: Counter, viewType: ViewType) {
        self.counter = counter
        self.viewType = viewType
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Group {
                Text("Child View \(viewType.rawValue)")
                
                Text("\(counter.value)")
                    .bold()
            }
            .font(.title)
            
            Button("Increment from \(viewType.rawValue)") {
                counter.increment()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    NavigationStack { Task7View() }
}
