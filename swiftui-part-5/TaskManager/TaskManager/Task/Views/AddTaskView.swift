import SwiftUI

struct AddTaskView: View {
    
    @EnvironmentObject private var manager: TaskManager
    
    @State private var taskText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                addTextField
                addButton
            }
            .navigationTitle("Add task")
        }
    }
}

#Preview {
    AddTaskView()
        .environmentObject(TaskManager())
}

private extension AddTaskView {
    
    private var addTextField: some View {
        TextField("Task", text: $taskText, prompt: Text("Enter your task..."))
            .padding()
            .background(.secondary.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
            .padding()
    }
    
    private var addButton: some View {
        Button {
            manager.addTask(taskText)
            taskText = ""
        } label: {
            Label("Add task", systemImage: "plus.circle.fill")
                .font(.title3)
        }
        .buttonStyle(.borderedProminent)
        .disabled(taskText.isEmpty)
    }
}
