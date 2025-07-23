import SwiftUI
import Observation

@MainActor @Observable
final class ImageGridViewModel {
    
    private(set) var config: AppConfig?
    private(set) var images: [UIImage] = []
    
    @ObservationIgnored private let configLoader: ConfigLoader
    @ObservationIgnored private let imageLoader: ImageLoader
    
    init(configLoader: ConfigLoader, imageLoader: ImageLoader) {
        self.configLoader = configLoader
        self.imageLoader = imageLoader
    }
    
    func load() {
        do {
            let config = try configLoader.loadConfig()
            self.config = config
            
            let selectedImages = imageLoader.imageNames().prefix(config.numberOfImages)
            self.images = selectedImages.compactMap { imageLoader.loadImage(name: $0) }
        } catch {
            print("failed loading: ", error)
        }
    }
}
