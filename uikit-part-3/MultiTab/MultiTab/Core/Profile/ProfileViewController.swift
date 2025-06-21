//
//  ProfileViewController.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let nameLabel = UILabel()
    private let editProfileButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"
        
        print("PROFILE - viewDidLoad")
        
        setupNavigationBar()
        setupNameLabel()
        setupEditProfileButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("PROFILE - viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("PROFILE - viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("PROFILE - viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("PROFILE - viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("PROFILE - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("PROFILE -  viewDidDisappear")
    }
    
    private func setupNavigationBar() {
        let rename = UIBarButtonItem(
            image: UIImage(systemName: "pencil.slash"),
            style: .plain,
            target: self,
            action: #selector(didTapRename)
        )
        
        let anonymous = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapAnonymous)
        )
        
        rename.tintColor = .black
        anonymous.tintColor = .black
        
        navigationItem.rightBarButtonItems = [rename, anonymous]
    }
    
    private func setupNameLabel() {
        nameLabel.text = User.shared.name ?? "Default"
        nameLabel.font = .systemFont(ofSize: 24)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40)
        ])
    }
    
    private func setupEditProfileButton() {
        var config = UIButton.Configuration.filled()
        config.title = "Edit Profile"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        editProfileButton.configuration = config
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.addTarget(self, action: #selector(didTapEditProfile), for: .touchUpInside)
        
        view.addSubview(editProfileButton)
        
        NSLayoutConstraint.activate([
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editProfileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            editProfileButton.heightAnchor.constraint(equalToConstant: 50),
            editProfileButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc private func didTapRename() {
        let alert = UIAlertController(title: "Rename", message: "Enter a new name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Your new name..."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            let text = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            guard let changedName = text, !changedName.isEmpty else {
                User.shared.name = "Default"
                self?.nameLabel.text = "Default"
                return
            }
            
            User.shared.name = changedName
            self?.nameLabel.text = changedName
        }))
        
        present(alert, animated: true)
    }
    
    @objc private func didTapAnonymous() {
        User.shared.name = "Anonymous"
        nameLabel.text = "Anonymous"
    }
    
    @objc private func didTapEditProfile() {
        let editProfileVC = EditProfileViewController()
        editProfileVC.title = "Edit profile"
        
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
}
