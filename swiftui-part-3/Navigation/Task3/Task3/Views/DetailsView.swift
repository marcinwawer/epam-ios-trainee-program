import SwiftUI

struct DetailsView: View {
    
    let fruit: Fruit
    
    @State private var showMoreInfo = false
    
    init(fruit: Fruit) {
        self.fruit = fruit
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "apple.meditate")
                .font(.largeTitle)
                .foregroundStyle(fruit.color)
            
            Text(fruit.name)
                .font(.title)
            
            Button("Show More Info") {
                showMoreInfo = true
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle(fruit.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showMoreInfo) {
            MoreInfoSheet(fruit: fruit)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    NavigationStack { DetailsView(fruit: Fruit.mock()) }
}
