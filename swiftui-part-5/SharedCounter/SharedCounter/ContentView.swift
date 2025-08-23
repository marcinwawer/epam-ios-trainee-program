import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Display", systemImage: "lanyardcard") {
                CounterDisplayView()
            }
            
            Tab("Decrement", systemImage: "minus.circle") {
                DecrementCounterView()
            }
            
            Tab("Increment", systemImage: "plus.circle") {
                IncrementCounterView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Counter())
}
