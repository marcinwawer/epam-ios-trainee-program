import SwiftUI
import Observation

@MainActor @Observable
final class ImageListViewModel: ObservableObject {
    
    var photos: [Photo] = []
    var images: [String: UIImage] = [:]
    var reloadTrigger = 0
    
    @ObservationIgnored private let service: ImageService
    @ObservationIgnored private let cacheManager: ImageCache
    
    init(service: ImageService, cacheManager: ImageCache) {
        self.service = service
        self.cacheManager = cacheManager
    }
    
    func load() async {
        do {
            photos = try await service.fetchPhotos()
        } catch {
            print("failed to fetch photos: ", error)
        }
    }
    
    func loadImage(for photo: Photo) async {
        guard let url = URL(string: photo.id) else { return }
        
        do {
            let data = try await cacheManager.imageData(for: url)
            if let image = UIImage(data: data) {
                images[photo.id] = image
            }
        } catch {
            print("failed to load image \(photo.id): ", error)
        }
    }
    
    func clearCache() {
        do {
            try cacheManager.clearCache()
            images.removeAll()
            reloadTrigger += 1
            print("cache cleared by user")
        } catch {
            print("failed to clear cache: ", error)
        }
    }
}
