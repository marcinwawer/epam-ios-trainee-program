import UIKit

class Task3ViewController: UIViewController {
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "quit the app and then reopen it"
        label.font = .boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    deinit {
        removeObservers()
        print("task 3 observers removed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Task 3: App State"
        view.backgroundColor = .systemBackground
        
        view.addSubview(infoLabel)
        addObservers()
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func appDidEnterBackground(_ notification: Notification) {
        print("enter background at \(getTime())")
    }
    
    @objc private func appDidEnterForeground(_ notification: Notification) {
        print("enter foreground at \(getTime())")
    }
    
    private func getTime() -> String {
        return DateFormatter.localizedString(
            from: Date(),
            dateStyle: .none,
            timeStyle: .medium
        )
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
}
