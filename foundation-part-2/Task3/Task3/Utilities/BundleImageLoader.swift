import SwiftUI

struct BundleImageLoader: ImageLoader {
    
    private let bundle: BundleProtocol
    private let fileExtension: String
    
    init(bundle: BundleProtocol = Bundle.main, fileExtension: String = "jpg") {
        self.bundle = bundle
        self.fileExtension = fileExtension
    }
    
    func imageNames() -> [String] {
        let urls = bundle.urls(forResourcesWithExtension: fileExtension, subdirectory: nil) ?? []
        return urls.map { $0.deletingPathExtension().lastPathComponent }.sorted()
    }
    
    func loadImage(name: String) -> UIImage? {
        guard let url = bundle.url(forResource: name, withExtension: fileExtension),
              let data = try? Data(contentsOf: url)
        else { return nil }
        
        return UIImage(data: data)
    }
}
