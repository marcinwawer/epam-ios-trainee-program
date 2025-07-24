import UIKit

class Task1SenderViewController: UIViewController {
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Notification", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Task 1: Sender"
        view.backgroundColor = .systemBackground
        
        view.addSubview(sendButton)
        addConstraints()
        setupSendButton()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupSendButton() {
        sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
    }
    
    @objc private func didTapSend() {
        let listener = Task1ListenerViewController()
        navigationController?.pushViewController(listener, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            NotificationCenter.default.post(
                name: .buttonTappedNotification,
                object: nil,
                userInfo: ["message": "notification sent at \(Date())"]
            )
        }
    }
}
