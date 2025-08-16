import SwiftUI

struct Fruit: Identifiable {
    
    let id = UUID()
    let name: String
    let color: Color
    let weight: Double
}

extension Fruit {
    
    static func mock(
        name: String = "Mock Fruit",
        color: Color = .blue,
        weight: Double = 1.0
    ) -> Fruit {
        .init(name: name, color: color, weight: weight)
    }
}
