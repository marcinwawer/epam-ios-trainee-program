import SwiftUI
import Combine
import Observation

@Observable
final class ButtonViewModel {
    
    private(set) var pressCount = 0
    
    @ObservationIgnored let didTapButtonSubject = PassthroughSubject<(), Never>()
    @ObservationIgnored private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        didTapButtonSubject
            .sink { [weak self] in
                guard let self else { return }
                self.pressCount += 1
                print("button tapped: \(self.pressCount)")
            }
            .store(in: &cancellables)
    }
    
    func didTapButton() {
        didTapButtonSubject.send()
    }
}

struct Task7View: View {
    
    @State private var vm = ButtonViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Button tapped: \(vm.pressCount)")
                .font(.largeTitle)
            
            Button("Tap me") {
                vm.didTapButton()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Task 7")
    }
}

#Preview {
    NavigationStack { Task7View() }
}
