import SwiftUI

struct MoreInfoSheet: View {
    
    let fruit: Fruit
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "apple.meditate")
                .font(.largeTitle)
                .foregroundStyle(fruit.color)
            
            Text(fruit.name)
                .font(.title)
            
            VStack(spacing: 4) {
                Text("Color: \(fruit.color)")
                Text("Weight \(fruit.weight, specifier: "%.2f") kg")
            }
        }
    }
}

#Preview {
    MoreInfoSheet(fruit: Fruit.mock())
}
