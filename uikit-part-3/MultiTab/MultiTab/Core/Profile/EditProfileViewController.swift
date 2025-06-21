//
//  EditProfileViewController.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Edit Profile"
        
        print("EDIT PROFILE - viewDidLoad")
        setupLabel()
        
        label.text = "LOADED"
        view.backgroundColor = .systemGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("EDIT PROFILE - viewWillAppear")
        label.textColor = .blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("EDIT PROFILE - viewDidAppear")
        label.text = "APPEARED"
        view.backgroundColor = .systemGreen
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("EDIT PROFILE - viewWillLayoutSubviews")
        label.textColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("EDIT PROFILE - viewDidLayoutSubviews")
        label.text = "LAYOUT DONE"
        view.backgroundColor = .systemOrange
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("EDIT PROFILE - viewWillDisappear")
        label.text = "WILL DISSAPEAR"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("EDIT PROFILE - viewDidDisappear")
    }
    
    private func setupLabel() {
        label.text = "TEST"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
