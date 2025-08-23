import SwiftUI

@main
struct SharedCounterApp: App {
    
    @StateObject private var counter = Counter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(counter)
        }
    }
}
