import SwiftUI
import Combine

final class LoadingViewModel {
    
    @Published private(set) var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $isLoading
            .sink {
                print("loading state changed: \($0)")
            }
            .store(in: &cancellables)
    }
    
    func startLoading() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
        }
    }
}

struct Task8View: View {
    
    private let vm = LoadingViewModel()
    
    var body: some View {
        VStack {
            Button("Start Loading") {
                vm.startLoading()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Task 8")
    }
}

#Preview {
    NavigationStack { Task8View() }
}
