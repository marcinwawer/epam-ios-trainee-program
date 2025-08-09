import SwiftUI

struct CardView<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
            
            content
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

struct Task5View: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                CardView(title: "Developer #1") {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.title)
                        
                        Text("John Doe")
                            .bold()
                    }
                }
                
                CardView(title: "Developer #2") {
                    HStack {
                        Image(systemName: "person.icloud")
                            .font(.title)
                        
                        Text("Jane Doe")
                            .bold()
                    }
                }
                
                CardView(title: "Developer #3") {
                    HStack {
                        Image(systemName: "person.fill.viewfinder")
                            .font(.title)
                        
                        Text("Marcin")
                            .bold()
                    }
                }
            }
        }
        .navigationTitle("Task 5")
    }
}

#Preview {
    NavigationStack { Task5View() }
}
