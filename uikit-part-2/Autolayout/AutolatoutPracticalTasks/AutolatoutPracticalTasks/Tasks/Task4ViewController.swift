//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.

final class Task4ViewController: UIViewController {
    
    private let subviewOne = UIView()
    private let subviewTwo = UIView()
    
    private let labelOne = UILabel()
    private let labelTwo = UILabel()
    
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerForTraitChanges()
        addConstraints()
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            if self.traitCollection.horizontalSizeClass == .compact && self.traitCollection.verticalSizeClass == .compact {
                self.stackView.axis = .horizontal
            } else {
                self.stackView.axis = .vertical
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBlue
        
        subviewOne.backgroundColor = .white
        subviewTwo.backgroundColor = .black
        
        labelOne.text = "1"
        labelOne.font = .systemFont(ofSize: 40, weight: .bold)
        labelOne.textColor = .black
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        
        labelTwo.text = "2"
        labelTwo.font = .systemFont(ofSize: 40, weight: .bold)
        labelTwo.textColor = .white
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        
        subviewOne.addSubview(labelOne)
        subviewTwo.addSubview(labelTwo)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(subviewOne)
        stackView.addArrangedSubview(subviewTwo)
        
        view.addSubview(stackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            labelOne.centerXAnchor.constraint(equalTo: subviewOne.centerXAnchor),
            labelOne.centerYAnchor.constraint(equalTo: subviewOne.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelTwo.centerXAnchor.constraint(equalTo: subviewTwo.centerXAnchor),
            labelTwo.centerYAnchor.constraint(equalTo: subviewTwo.centerYAnchor)
        ])
    }
}

#Preview {
    Task4ViewController()
}
