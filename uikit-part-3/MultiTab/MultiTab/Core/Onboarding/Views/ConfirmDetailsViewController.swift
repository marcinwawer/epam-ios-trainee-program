//
//  ConfirmDetailsViewController.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class ConfirmDetailsViewController: UIViewController {
    
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let notificationLabel = UILabel()
    
    private let startOverButton = UIButton()
    private let editPreferencesButton = UIButton()
    private let editPersonalInfoButton = UIButton()
    private let confirmButton = UIButton()
    
    private let labelStackView = UIStackView()
    private let buttonStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Confirm Details"
        
        navigationItem.hidesBackButton = true
        
        setupLabels()
        setupStackViews()
        setupButtons()
    }
    
    private func setupLabels() {
        nameLabel.text = "Name: \(User.shared.name ?? "—")"
        phoneLabel.text = "Phone Number: \(User.shared.phoneNumber ?? "—")"
        notificationLabel.text = "Notification Preference: \(User.shared.notificactionPreference?.rawValue ?? "Not selected")"
        
        [nameLabel, phoneLabel, notificationLabel].forEach {
            $0.font = .systemFont(ofSize: 18)
            $0.numberOfLines = 0
            $0.textColor = .black
        }
    }
    
    private func setupButtons() {
        configureButton(startOverButton, title: "Start Over", color: .systemRed, action: #selector(didTapStartOver))
        configureButton(editPreferencesButton, title: "Edit Preferences", color: .systemBlue, action: #selector(didTapEditPreferences))
        configureButton(editPersonalInfoButton, title: "Edit Personal Info", color: .systemBlue, action: #selector(didTapEditPersonalInfo))
        configureButton(confirmButton, title: "Confirm", color: .systemGreen, action: #selector(didTapConfirm))
        
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 40),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            confirmButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configureButton(_ button: UIButton, title: String, color: UIColor, action: Selector) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = color
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func setupStackViews() {
        setupLabelStackView()
        setupButtonStackView()
    }
    
    private func setupLabelStackView() {
        labelStackView.axis = .vertical
        labelStackView.spacing = 16
        labelStackView.alignment = .leading
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(phoneLabel)
        labelStackView.addArrangedSubview(notificationLabel)
        
        view.addSubview(labelStackView)
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupButtonStackView() {
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 16
        buttonStackView.alignment = .center
        buttonStackView.alignment = .fill
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.addArrangedSubview(editPreferencesButton)
        buttonStackView.addArrangedSubview(editPersonalInfoButton)
        buttonStackView.addArrangedSubview(startOverButton)
        
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        ])
    }
    
    @objc private func didTapStartOver() {
        User.shared.clearUserData()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didTapEditPreferences() {
        if let preferencesVC = navigationController?.viewControllers.first(where: { $0 is PreferencesViewController }) {
            navigationController?.popToViewController(preferencesVC, animated: true)
        }
    }
    
    @objc private func didTapEditPersonalInfo() {
        if let personalInfoVC = navigationController?.viewControllers.first(where: { $0 is PersonalInfoViewController }) {
            navigationController?.popToViewController(personalInfoVC, animated: true)
        }
    }
    
    @objc private func didTapConfirm() {
        let alert = UIAlertController(
            title: "Success",
            message: "You have successfully passed the onboarding",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            User.shared.isRegistered = true
            self?.navigationController?.popToRootViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
}

#Preview {
    ConfirmDetailsViewController()
}
