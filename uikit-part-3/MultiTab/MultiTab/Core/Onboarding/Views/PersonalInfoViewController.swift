//
//  PersonalInfoViewController.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    
    private let nameField = UITextField()
    private let phoneField = UITextField()
    
    private let confirmButton = UIButton()
    
    private let stackView = UIStackView()
    
    private var keyboardHandler: KeyboardHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Personal Info"
        
        keyboardHandler = KeyboardHandler(viewController: self)
        
        setupLabels()
        setupTextFields()
        setupButton()
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        setupStackView()
    }
    
    private func setupLabels() {
        titleLabel.text = "Enter your personal info"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        bodyLabel.text = """
        Enter your name and phone number
        """
    }
    
    private func setupTextFields() {
        nameField.placeholder = "Enter your name..."
        phoneField.placeholder = "Enter phone number..."
        nameField.borderStyle = .roundedRect
        phoneField.borderStyle = .roundedRect
        
        nameField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        phoneField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        phoneField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupButton() {
        var config = UIButton.Configuration.filled()
        config.title = "Confirm"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        confirmButton.configuration = config
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        confirmButton.isEnabled = false
        confirmButton.alpha = 0.5
        
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            confirmButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 12
        
        let fieldsStack = UIStackView(arrangedSubviews: [nameField, phoneField])
        fieldsStack.axis = .vertical
        fieldsStack.spacing = 16
        
        stackView.addArrangedSubview(labelsStack)
        stackView.setCustomSpacing(40, after: labelsStack)
        stackView.addArrangedSubview(fieldsStack)
        stackView.setCustomSpacing(20, after: fieldsStack)
        stackView.addArrangedSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            phoneField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }
    
    @objc private func textFieldsDidChange() {
        let nameText = nameField.text ?? ""
        let phoneText = phoneField.text ?? ""
        
        let isFormValid = !nameText.trimmingCharacters(in: .whitespaces).isEmpty && phoneText.count >= 9
        
        confirmButton.isEnabled = isFormValid
        confirmButton.alpha = isFormValid ? 1.0 : 0.5
    }
    
    @objc private func didTapConfirmButton() {
        let alert = UIAlertController(
            title: "Confirm Information",
            message: "Please confirm your name and phone number. Name: \(nameField.text ?? ""), Phone: \(phoneField.text ?? "")",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Edit", style: .destructive))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
            if let name = self?.nameField.text, let phone = self?.phoneField.text {
                User.shared.name = name
                User.shared.phoneNumber = phone
            }
            
            let preferencesVC = PreferencesViewController()
            preferencesVC.title = "Preferences"
            self?.navigationController?.pushViewController(preferencesVC, animated: true)
        }))
        
        present(alert, animated: true)
    }
}
