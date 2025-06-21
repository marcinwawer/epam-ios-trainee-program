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
    
    private var verticalConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addConstraints()
        registerForTraitChanges()
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .compact {
            NSLayoutConstraint.activate(horizontalConstraints)
        } else {
            NSLayoutConstraint.activate(verticalConstraints)
        }
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            if self.traitCollection.horizontalSizeClass == .compact && self.traitCollection.verticalSizeClass == .compact {
                NSLayoutConstraint.deactivate(self.verticalConstraints)
                NSLayoutConstraint.activate(self.horizontalConstraints)
            } else {
                NSLayoutConstraint.deactivate(self.horizontalConstraints)
                NSLayoutConstraint.activate(self.verticalConstraints)
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
        subviewOne.translatesAutoresizingMaskIntoConstraints = false
        subviewTwo.addSubview(labelTwo)
        subviewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(subviewOne)
        view.addSubview(subviewTwo)
        subviewOne.addSubview(labelOne)
        subviewTwo.addSubview(labelTwo)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            labelOne.centerXAnchor.constraint(equalTo: subviewOne.centerXAnchor),
            labelOne.centerYAnchor.constraint(equalTo: subviewOne.centerYAnchor),
            
            labelTwo.centerXAnchor.constraint(equalTo: subviewTwo.centerXAnchor),
            labelTwo.centerYAnchor.constraint(equalTo: subviewTwo.centerYAnchor),
        ])
        
        verticalConstraints = [
            subviewOne.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            subviewOne.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            subviewOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            subviewOne.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5, constant: -10),
            
            subviewTwo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            subviewTwo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            subviewTwo.topAnchor.constraint(equalTo: subviewOne.bottomAnchor, constant: 10),
            subviewTwo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ]
        
        horizontalConstraints = [
            subviewOne.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            subviewOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            subviewOne.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            subviewOne.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: -10),
            
            subviewTwo.leadingAnchor.constraint(equalTo: subviewOne.trailingAnchor, constant: 10),
            subviewTwo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            subviewTwo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            subviewTwo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ]
    }
}

#Preview {
    Task4ViewController()
}
