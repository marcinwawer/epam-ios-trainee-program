import SwiftUI

struct IncrementCounterView: View {
    
    @EnvironmentObject private var counter: Counter
    
    var body: some View {
        NavigationStack {
            Button(action: counter.increment) {
                Label("Increment", systemImage: "plus.circle.fill")
                    .font(.title2)
            }
            .buttonStyle(.borderedProminent)
            .navigationTitle("Increment View")
        }
    }
}

#Preview {
    IncrementCounterView()
        .environmentObject(Counter())
}
