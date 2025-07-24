import UIKit

class Task1ListenerViewController: UIViewController {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "waiting for notification..."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Task 1: Listener"
        view.backgroundColor = .systemBackground
        
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification),
            name: .buttonTappedNotification,
            object: nil
        )
    }
    
    @objc private func handleNotification(_ notification: Notification) {
        if let message = notification.userInfo?["message"] as? String {
            self.messageLabel.text = message
        } else {
            self.messageLabel.text = "notification received"
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: .buttonTappedNotification,
            object: nil
        )
    }
}
