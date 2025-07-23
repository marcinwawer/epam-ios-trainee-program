import SwiftUI

struct ImageListView: View {
    
    private enum Constants {
        
        static let imageSize: CGFloat = 80
    }
    
    @State private var vm: ImageListViewModel
    
    init(viewModel: ImageListViewModel) {
        vm = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List(vm.photos) { photo in
                listCell(photo: photo)
                    .task(id: photo.id) {
                        await vm.loadImage(for: photo)
                    }
                    .onChange(of: vm.reloadTrigger, { _, _ in
                        Task { await vm.loadImage(for: photo) }
                    })
            }
            .navigationTitle("Beagle Photos 🐶")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear Cache") {
                        vm.clearCache()
                    }
                }
            }
            .task {
                await vm.load()
            }
        }
    }
}

extension ImageListView {
    
    @ViewBuilder
    private func listCell(photo: Photo) -> some View {
        HStack {
            if let image = vm.images[photo.id] {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
            } else {
                ProgressView()
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
            }
            
            Text(photo.id)
                .lineLimit(3)
        }
    }
}

/*
extension ImageListView {
    
    init() {
        let cacheManager = try! ImageCacheManager()
        let service = DogService()
        let vm = ImageListViewModel(service: service, cacheManager: cacheManager)
        self.init(viewModel: vm)
    }
}

#Preview {
    ImageListView()
}
*/
