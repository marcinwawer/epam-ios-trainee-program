import SwiftUI

@main
struct BundledImagesApp: App {
    
    let viewModel: ImageGridViewModel
    
    init() {
        let bundle: BundleProtocol = Bundle.main
        let configLoader = JSONConfig(bundle: bundle, fileName: "config", fileExtension: "json")
        let imageLoader = BundleImageLoader(bundle: bundle, fileExtension: "jpg")
        viewModel = ImageGridViewModel(configLoader: configLoader, imageLoader: imageLoader)
    }
    
    var body: some Scene {
        WindowGroup {
            ImageGridView(viewModel: viewModel)
        }
    }
}
