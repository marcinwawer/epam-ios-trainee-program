import SwiftUI

struct RemoveTaskView: View {
    
    @EnvironmentObject private var manager: TaskManager
    
    @State private var indexText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                removeTextField
                removeButton
            }
            .navigationTitle("Remove task")
        }
    }
    
    private func checkIndexValidity() -> Bool {
        guard let intValue = Int(indexText) else { return false }
        return intValue >= 0 && intValue < manager.tasks.count
    }
}

#Preview {
    RemoveTaskView()
        .environmentObject(TaskManager())
}

extension RemoveTaskView {
    
    private var removeTextField: some View {
        TextField("Index", text: $indexText, prompt: Text("Enter index of the task you want to delete"))
            .keyboardType(.numberPad)
            .padding()
            .background(.secondary.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
            .padding()
    }
    
    private var removeButton: some View {
        Button {
            manager.removeTask(at: Int(indexText))
            indexText = ""
        } label: {
            Label("Remove task", systemImage: "minus.circle.fill")
                .font(.title3)
        }
        .buttonStyle(.borderedProminent)
        .disabled(indexText.isEmpty || !checkIndexValidity())
    }
}
