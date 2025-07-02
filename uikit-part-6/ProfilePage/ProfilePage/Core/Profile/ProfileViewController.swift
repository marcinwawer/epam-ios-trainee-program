//
//  ProfileViewController.swift
//  ProfilePage
//
//  Created by Marcin Wawer on 01-07-2025.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var taggedFlag = false
    private var isFollowing = false
     
    private let followersLabel = UILabel()
    private let followingLabel = UILabel()
    private let postsLabel = UILabel()
    
    private let profileHeaderStackView = UIStackView()
    private let statisticsStackView = UIStackView()
    private let taggedPostsStackView = UIStackView()
    private let mainStackView = UIStackView()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: DeveloperPreview.shared.user.profilePhotoURL))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 40
        
        NSLayoutConstraint.activate([
            iv.widthAnchor.constraint(equalToConstant: 80),
            iv.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.text = DeveloperPreview.shared.user.name
        
        return label
    }()
    
    private let followButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Follow"
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.text = DeveloperPreview.shared.user.bio
        label.numberOfLines = 10
        
        return label
    }()
    
    private func makeStat(title: String, count: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .secondaryLabel
        titleLabel.text = title
        
        let countLabel = UILabel()
        countLabel.font = .boldSystemFont(ofSize: 15)
        countLabel.text = count
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4
        
        return stack
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile Details"
        
        setupProfileHeaderStackView()
        setupStatisticsStackView()
        setupTaggedPostsStackView()
        setupMainStackView()
        setupTaggedButton()
        setupFollowButton()
    }
      
    private func setupProfileHeaderStackView() {
        profileHeaderStackView.axis = .horizontal
        profileHeaderStackView.alignment = .center
        profileHeaderStackView.spacing = 16
        profileHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        profileHeaderStackView.addArrangedSubview(profileImageView)
        profileHeaderStackView.addArrangedSubview(nameLabel)
        profileHeaderStackView.addArrangedSubview(UIView())
        profileHeaderStackView.addArrangedSubview(followButton)
    }
    
    private func setupStatisticsStackView() {
        statisticsStackView.axis = .horizontal
        statisticsStackView.alignment = .center
        statisticsStackView.distribution = .equalSpacing
        statisticsStackView.spacing = 20
        statisticsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let followers = makeStat(title: "Followers:", count: DeveloperPreview.shared.user.followersCount.description)
        let following = makeStat(title: "Following:", count: DeveloperPreview.shared.user.followingCount.description)
        let posts = makeStat(title: "Posts:", count: DeveloperPreview.shared.user.postsCount.description)
        
        statisticsStackView.addArrangedSubview(followers)
        statisticsStackView.addArrangedSubview(following)
        statisticsStackView.addArrangedSubview(posts)
    }
    
    private func setupTaggedPostsStackView() {
        taggedPostsStackView.axis = .vertical
        taggedPostsStackView.alignment = .leading
        taggedPostsStackView.spacing = 8
        taggedPostsStackView.translatesAutoresizingMaskIntoConstraints = false
        taggedPostsStackView.isHidden = true
        
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 18)
        title.text = "Tagged Posts"
        
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = 12
        
        for _ in 0..<5 {
            row.addArrangedSubview(makeCircle())
        }
        
        taggedPostsStackView.addArrangedSubview(title)
        taggedPostsStackView.addArrangedSubview(row)
    }
    
    private func setupMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.spacing = 24
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(profileHeaderStackView)
        mainStackView.addArrangedSubview(bioLabel)
        mainStackView.addArrangedSubview(statisticsStackView)
        mainStackView.addArrangedSubview(taggedPostsStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTaggedButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: taggedFlag ? "tag.circle.fill" : "tag.circle"),
            style: .plain,
            target: self,
            action: #selector(toggleTaggedPosts)
        )
    }
    
    private func setupFollowButton() {
        followButton.addTarget(
            self,
            action: #selector(didTapFollow),
            for: .touchUpInside
        )
    }
}

// MARK: - BUTTONS ACTIONS
extension ProfileViewController {
    
    @objc private func toggleTaggedPosts() {
        let showing = taggedPostsStackView.isHidden
        taggedPostsStackView.isHidden = false
        taggedPostsStackView.alpha = showing ? 0 : 1
        taggedFlag.toggle()
        setupTaggedButton()
        
        UIView.animate(withDuration: 0.3) {
            self.taggedPostsStackView.alpha = showing ? 1 : 0
        } completion: { _ in
            self.taggedPostsStackView.isHidden = !showing
        }
    }
    
    @objc private func didTapFollow() {
        isFollowing.toggle()
        
        if var newConfig = followButton.configuration {
            newConfig.title = isFollowing ? "Unfollow" : "Follow"
            newConfig.baseBackgroundColor = isFollowing ? .systemGray : .systemBlue
            
            UIView.transition(with: followButton, duration: 0.3, options: .transitionCrossDissolve) {
                self.followButton.configuration?.title = self.isFollowing ? "Unfollow" : "Follow"
                self.followButton.configuration?.baseBackgroundColor = self.isFollowing ? .systemGray : .systemBlue
            }
        }
    }
}

// MARK: - HELPERS
extension ProfileViewController {
    
    private func makeCircle() -> UIView {
        let circle = UIView()
        circle.backgroundColor = .gray
        circle.layer.cornerRadius = 30
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circle.widthAnchor.constraint(equalToConstant: 60),
            circle.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        return circle
    }
}

#Preview {
    UINavigationController(rootViewController: ProfileViewController())
}
