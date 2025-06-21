//
//  PreferencesViewController.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    private let notificationOptionButton = UIButton()
    private let finishButton = UIButton()
    
    private let notificationOptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Preferences"
        
        setupNotificationButton()
        setupFinishButton()
        setupLabel()
    }
    
    private func setupLabel() {
        notificationOptionLabel.text = "Notifications: \(User.shared.notificactionPreference?.rawValue ?? "Not set")"
        notificationOptionLabel.font = .boldSystemFont(ofSize: 24)
        notificationOptionLabel.textColor = .black
        
        view.addSubview(notificationOptionLabel)
        
        notificationOptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notificationOptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationOptionLabel.topAnchor.constraint(equalTo: notificationOptionButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupNotificationButton() {
        var config = UIButton.Configuration.filled()
        config.title = "Select Notifications Option"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        notificationOptionButton.configuration = config
        notificationOptionButton.translatesAutoresizingMaskIntoConstraints = false
        notificationOptionButton.addTarget(self, action: #selector(didTapNotificationOptionButton), for: .touchUpInside)
        
        view.addSubview(notificationOptionButton)
        
        NSLayoutConstraint.activate([
            notificationOptionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationOptionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notificationOptionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupFinishButton() {
        var config = UIButton.Configuration.filled()
        config.title = "Finish Onboarding"
        config.baseBackgroundColor = .systemGreen
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        finishButton.configuration = config
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.addTarget(self, action: #selector(didTapFinishButton), for: .touchUpInside)
        
        view.addSubview(finishButton)
        
        NSLayoutConstraint.activate([
            finishButton.heightAnchor.constraint(equalToConstant: 50),
            finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func didTapNotificationOptionButton() {
        let actionSheet = UIAlertController(
            title: "Select Notification Preference",
            message: "Please choose your preferred method for receiving notifications",
            preferredStyle: .actionSheet
        )
        
        actionSheet.addAction(UIAlertAction(title: NotificationPreference.email.rawValue, style: .default, handler: { _ in
            User.shared.notificactionPreference = .email
            self.updateNotificationLabel()
        }))
        
        actionSheet.addAction(UIAlertAction(title: NotificationPreference.sms.rawValue, style: .default, handler: { _ in
            User.shared.notificactionPreference = .sms
            self.updateNotificationLabel()
        }))
        
        actionSheet.addAction(UIAlertAction(title: NotificationPreference.push.rawValue, style: .default, handler: { _ in
            User.shared.notificactionPreference = .push
            self.updateNotificationLabel()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    @objc private func didTapFinishButton() {
        let confirmDetailsVC = ConfirmDetailsViewController()
        confirmDetailsVC.title = "Confirm Details"
        navigationController?.pushViewController(confirmDetailsVC, animated: true)
    }
    
    private func updateNotificationLabel() {
        notificationOptionLabel.text = "Notifications: \(User.shared.notificactionPreference?.rawValue ?? "Not set")"
    }
}
