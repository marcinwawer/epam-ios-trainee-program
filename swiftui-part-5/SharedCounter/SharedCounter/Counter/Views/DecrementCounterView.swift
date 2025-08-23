import SwiftUI

struct DecrementCounterView: View {
    
    @EnvironmentObject private var counter: Counter
    
    var body: some View {
        NavigationStack {
            Button(action: counter.decrement) {
                Label("Decrement", systemImage: "minus.circle.fill")
                    .font(.title2)
            }
            .buttonStyle(.borderedProminent)
            .navigationTitle("Decrement View")
        }
    }
}

#Preview {
    DecrementCounterView()
        .environmentObject(Counter())
}
