import Foundation

@MainActor
final class TaskManager: ObservableObject {
    
    @Published var tasks = [String]()
    
    func addTask(_ task: String) {
        tasks.append(task)
    }
    
    func removeTask(at index: Int?) {
        guard let index,
              index >= 0,
              index <= tasks.count
        else { return }
        
        tasks.remove(at: index)
    }
}
