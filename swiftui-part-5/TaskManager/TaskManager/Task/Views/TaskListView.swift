import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject private var manager: TaskManager
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if manager.tasks.isEmpty {
                    emptyView
                } else {
                    List(Array(manager.tasks.enumerated()), id: \.element.self) { index, task in
                        HStack {
                            Text("\(index).")
                            Text(task)
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    TaskListView()
        .environmentObject(TaskManager())
}

extension TaskListView {
    
    private var emptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "pencil.slash")
                .font(.largeTitle)
            
            Text("There are no tasks 😭")
                .font(.title3)
        }
    }
}
