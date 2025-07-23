import SwiftUI

struct ImageGridView: View {
    
    @State private var vm: ImageGridViewModel
    private var columns: [GridItem] {
        let count = vm.config?.gridColumns ?? 1
        return Array(repeating: .init(.flexible()), count: count)
    }
    
    init(viewModel: ImageGridViewModel) {
        vm = viewModel
    }
    
    var body: some View {
        NavigationStack {
            if let config = vm.config {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(vm.images.indices, id: \.self) {
                            Image(uiImage: vm.images[$0])
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding()
                }
                .navigationTitle(config.gridName)
            } else {
                ProgressView()
                    .task { vm.load() }
            }
        }
    }
}

/*
 extension ImageGridView {
 
     init() {
         let bundle: BundleProtocol = Bundle.main
         let configLoader = JSONConfig(bundle: bundle, fileName: "config", fileExtension: "json")
         let imageBundle = BundleImageLoader(bundle: bundle, fileExtension: "jpg")
         let vm = ImageGridViewModel(configLoader: configLoader, imageLoader: imageBundle)
         self.init(viewModel: vm)
     }
 }
 
 #Preview {
     ImageGridView()
 }
*/
