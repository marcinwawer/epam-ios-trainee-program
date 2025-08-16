import SwiftUI

struct ContentView: View {
    
    private let fruits: [Fruit] = [
        .init(name: "Apple", color: .red, weight: 0.4),
        .init(name: "Cherry", color: .pink, weight: 0.1),
        .init(name: "Banana", color: .yellow, weight: 0.5)
    ]
    
    var body: some View {
        NavigationStack {
            List(fruits) { fruit in
                NavigationLink {
                    DetailsView(fruit: fruit)
                } label: {
                    Text(Image(systemName: "apple.meditate.circle"))
                        .foregroundStyle(fruit.color)
                    
                    Text(fruit.name)
                }

            }
            .navigationTitle("Fruits 🍎")
        }
    }
}

#Preview {
    NavigationStack { ContentView() }
}
