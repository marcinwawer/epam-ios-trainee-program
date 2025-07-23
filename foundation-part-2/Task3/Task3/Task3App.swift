import SwiftUI

@main
struct BundledImagesApp: App {
    
    let viewModel: ImageGridViewModel
    
    init() {
        let bundle: BundleProtocol = Bundle.main
        let configLoader = JSONConfig(bundle: bundle, fileName: "config", fileExtension: "json")
        let imageBundle = DefaultImageBundleImpl(bundle: bundle, fileExtension: "jpg")
        viewModel = ImageGridViewModel(configLoader: configLoader, imageBundle: imageBundle)
    }
    
    var body: some Scene {
        WindowGroup {
            ImageGridView(viewModel: viewModel)
        }
    }
}
