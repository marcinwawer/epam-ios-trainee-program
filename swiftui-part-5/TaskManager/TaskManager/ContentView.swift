import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("List", systemImage: "list.bullet.circle") {
                TaskListView()
            }
            
            Tab("Add Task", systemImage: "plus.circle") {
                AddTaskView()
            }
            
            Tab("Remove Task", systemImage: "minus.circle") {
                RemoveTaskView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TaskManager())
}
