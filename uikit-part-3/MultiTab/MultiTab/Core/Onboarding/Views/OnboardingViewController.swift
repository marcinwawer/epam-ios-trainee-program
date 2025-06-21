//
//  OnboardingViewController.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Onboarding"
        view.backgroundColor = .systemBackground
        
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateButton()
    }
    
    private func updateButton() {
        var config = UIButton.Configuration.filled()
        config.title = User.shared.isRegistered ? "Restart" : "Start"
        config.baseBackgroundColor = User.shared.isRegistered ? .systemGreen : .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        startButton.configuration = config
    }
    
    private func setupButton() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        updateButton()
    }
    
    @objc private func didTapStartButton() {
        User.shared.clearUserData()
        
        let personalInfoVC = PersonalInfoViewController()
        personalInfoVC.title = "Personal Info"
        
        navigationController?.pushViewController(personalInfoVC, animated: true)
    }
}
