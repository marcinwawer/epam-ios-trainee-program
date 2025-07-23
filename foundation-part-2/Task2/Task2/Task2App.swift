import SwiftUI

@main
struct Task2App: App {
    
    let viewModel: ImageListViewModel
    
    init() {
        let cacheManager: ImageCacheManager
        
        do {
            cacheManager = try ImageCacheManager()
        } catch {
            fatalError("failed to initialize cache manager: \(error)")
        }
        
        let service = DogService()
        viewModel = ImageListViewModel(service: service, cacheManager: cacheManager)
    }
    
    var body: some Scene {
        WindowGroup {
            ImageListView(viewModel: viewModel)
        }
    }
}
