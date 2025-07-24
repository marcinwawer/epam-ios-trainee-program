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
    
    deinit {
        removeObservers()
        print("task 1 observers removed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Task 1: Listener"
        view.backgroundColor = .systemBackground

        view.addSubview(messageLabel)
        addConstraints()
        addObservers()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addObservers() {
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
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: .buttonTappedNotification,
            object: nil
        )
    }
}
