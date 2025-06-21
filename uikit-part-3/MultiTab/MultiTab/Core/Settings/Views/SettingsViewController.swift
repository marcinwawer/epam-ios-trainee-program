//
//  SettingsViewController.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let toggleLabel = UILabel()
    private let toggleSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupView()
    }
    
    private func setupView() {
        toggleLabel.text = "Navigation is easy!"
        toggleLabel.font = .systemFont(ofSize: 20)
        
        toggleLabel.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toggleLabel)
        view.addSubview(toggleSwitch)
        
        NSLayoutConstraint.activate([
            toggleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            toggleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toggleSwitch.leadingAnchor.constraint(equalTo: toggleLabel.trailingAnchor, constant: 16),
            toggleSwitch.centerYAnchor.constraint(equalTo: toggleLabel.centerYAnchor)
        ])
    }
}
