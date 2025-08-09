import SwiftUI

struct Product: Identifiable {
    
    let id = UUID()
    let name: String
    var isEnabled: Bool
}

struct Task6View: View {
    
    @State private var products: [Product] = [
        Product(name: "Milk", isEnabled: false),
        Product(name: "Bread", isEnabled: true),
        Product(name: "Eggs", isEnabled: false),
        Product(name: "Apples", isEnabled: true)
    ]
    
    var body: some View {
        List($products) { $product in
            Toggle(isOn: $product.isEnabled) {
                Text(product.name)
            }
        }
        .navigationTitle("Task 6")
    }
}

#Preview {
    NavigationStack { Task6View() }
}
