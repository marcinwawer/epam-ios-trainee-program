import UIKit
import SwiftUI

final class ViewController: UIViewController {
    
    private let presentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Present SUI View", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIKit View"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(presentButton)
        
        NSLayoutConstraint.activate([
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        presentButton.addTarget(self, action: #selector(presentSwiftUI), for: .touchUpInside)
    }
    
    @objc private func presentSwiftUI() {
        let host = UIHostingController(rootView: EmbeddedViewSUI())
        host.modalPresentationStyle = .formSheet
        present(host, animated: true)
    }
}
