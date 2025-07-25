import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Task 1", systemImage: "1.circle") {
                Task1View()
            }
            
            Tab("Task 2", systemImage: "2.circle") {
                Task2View()
            }
            
            Tab("Task 3", systemImage: "3.circle") {
                Task3View()
            }
        }
    }
}
