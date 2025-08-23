import SwiftUI
import UIKit

struct ViewControllerWrapper<VC: UIViewController>: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = VC
    
    let make: () -> VC
    let update: (VC) -> Void
    
    init(
        make: @escaping @autoclosure () -> VC,
        update: @escaping (VC) -> Void = { _ in }
    ) {
        self.make = make
        self.update = update
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        make()
    }
    
    func updateUIViewController(_ uiViewController: VC, context: Context) {
        update(uiViewController)
    }
}
