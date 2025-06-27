//
//  GymClassCell.swift
//  GymScheduleApp
//
//  Created by Marcin Wawer on 27-06-2025.
//

import UIKit

protocol GymClassCellDelegate: AnyObject {
    
    func gymClassCell(_ cell: GymClassCell, didTapRegisterFor gymClass: GymClass)
    func gymClassCell(_ cell: GymClassCell, didTapFavoriteFor gymClass: GymClass)
}

class GymClassCell: UITableViewCell {
    
    static let identifier = "GymClassCell"
    weak var delegate: GymClassCellDelegate?
    
    private let timeLabel = UILabel()
    private let durationLabel = UILabel()
    
    private let titleLabel = UILabel()
    private let trainerImageView = UIImageView()
    private let trainerLabel = UILabel()
    
    private let registerButton = UIButton()
    private let favoriteButton = UIButton()
    
    private var gymClass: GymClass?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupLabels()
        setupTrainerImage()
        setupRegisterButton()
        setupFavoriteButton()
        
        let timeDurationStack = setupTimeDurationStack()
        let trainerStack = setupTrainerStack()
        let titleTrainerStack = setupTitleTrainerStack(with: trainerStack)
        let mainStack = setupMainStack(timeDuration: timeDurationStack, titleTrainer: titleTrainerStack)
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            trainerImageView.widthAnchor.constraint(equalToConstant: 32),
            trainerImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupLabels() {
        timeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        timeLabel.textColor = .accent
        
        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = .secondaryAccent
        
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        trainerLabel.font = UIFont.systemFont(ofSize: 14)
        trainerLabel.textColor = .secondaryAccent
    }
    
    private func setupTrainerImage() {
        trainerImageView.contentMode = .scaleAspectFill
        trainerImageView.layer.cornerRadius = 16
        trainerImageView.clipsToBounds = true
        trainerImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupRegisterButton() {
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    private func setupFavoriteButton() {
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    }
    
    private func setupTimeDurationStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [timeLabel, durationLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        
        return stack
    }
    
    private func setupTrainerStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [trainerImageView, trainerLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        
        return stack
    }
    
    private func setupTitleTrainerStack(with trainerStack: UIStackView) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [titleLabel, trainerStack])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        return stack
    }
    
    private func setupMainStack(timeDuration: UIStackView, titleTrainer: UIStackView) -> UIStackView {
        let spacer = UIView()
        
        let stack = UIStackView(arrangedSubviews: [timeDuration, titleTrainer, spacer, favoriteButton, registerButton])
        stack.axis = .horizontal
        stack.spacing = 24
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }
    
    func configure(gymClass: GymClass) {
        self.gymClass = gymClass
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = formatter.string(from: gymClass.date)
        
        durationLabel.text = "\(Int(gymClass.duration / 60))m"
        titleLabel.text = gymClass.name
        trainerLabel.text = "\(gymClass.trainer.name) \(gymClass.trainer.surname)"
        
        if let image = UIImage(named: gymClass.trainer.profilePhotoURL) {
            trainerImageView.image = image
        } else {
            trainerImageView.image = UIImage(systemName: "person.crop.circle")
        }
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .light)
        
        let registerImage = gymClass.isRegistered ? UIImage(systemName: "xmark.circle.fill", withConfiguration: largeConfig) : UIImage(systemName: "plus.circle", withConfiguration: largeConfig)
        registerButton.setImage(registerImage, for: .normal)
        registerButton.tintColor = gymClass.isRegistered ? .accent : .gray
        
        let favoriteImage = gymClass.isFavorite ? UIImage(systemName: "heart.fill", withConfiguration: largeConfig) : UIImage(systemName: "heart", withConfiguration: largeConfig)
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.tintColor = gymClass.isFavorite ? .systemRed : .gray
    }
}

// MARK: - BUTTON ACTIONS
extension GymClassCell {
    
    @objc private func didTapRegister() {
        guard let gymClass else { return }
        delegate?.gymClassCell(self, didTapRegisterFor: gymClass)
    }
    
    @objc private func didTapFavorite() {
        guard let gymClass else { return }
        delegate?.gymClassCell(self, didTapFavoriteFor: gymClass)
    }
}
