//
//  TabViewController.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabBar()
        setupTabs()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .orange
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupTabs() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.title = "Onboarding"
        
        let onboardingNav = UINavigationController(rootViewController: onboardingVC)
        onboardingNav.tabBarItem.title = "Onboarding"
        onboardingNav.tabBarItem.image = UIImage(systemName: "star")
        
        let profileVC = ProfileViewController()
        profileVC.title = "Profile"
        
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem.title = "Profile"
        profileNav.tabBarItem.image = UIImage(systemName: "person")
        
        let settingsVC = SettingsViewController()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem.image = UIImage(systemName: "gear")
        
        self.setViewControllers([onboardingNav, profileNav, settingsVC], animated: true)
    }
}
