import SwiftUI

@main
struct TaskManagerApp: App {
    
    @StateObject private var counter = TaskManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TaskManager())
        }
    }
}
