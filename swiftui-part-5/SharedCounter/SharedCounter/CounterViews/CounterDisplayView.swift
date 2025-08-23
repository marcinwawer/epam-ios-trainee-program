import SwiftUI

struct CounterDisplayView: View {
    
    @EnvironmentObject private var counter: Counter
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Counter current value")
                    .font(.title)
                
                Text(counter.value.description)
                    .font(.largeTitle)
                    .bold()
            }
            .navigationTitle("Display View")
        }
    }
}

#Preview {
    CounterDisplayView()
        .environmentObject(Counter())
}
