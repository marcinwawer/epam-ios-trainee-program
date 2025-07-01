//
//  CustomCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Marcin Wawer on 30-06-2025.
//

import UIKit

protocol CustomCollectionViewCellDelegate: AnyObject {
    
    func customCollectionViewCellDidTapFavorite(_ cell: CustomCollectionViewCell)
    func customCollectionViewCellDidSwipeToDelete(_ cell: CustomCollectionViewCell)
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    weak var delegate: CustomCollectionViewCellDelegate?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .white
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipe.direction = .left
        contentView.addGestureRecognizer(swipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with item: ImageModel) {
        if let image = UIImage(named: item.imageURL) {
            imageView.image = image
        } 
        
        titleLabel.text = item.title
        
        let heartImage = item.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: heartImage), for: .normal)
        favoriteButton.tintColor = item.isFavorite ? .systemRed : .secondaryLabel
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
        
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: favoriteButton.leadingAnchor, constant: -4),
            
            favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
        
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    }
    
    @objc private func didTapFavorite() {
        delegate?.customCollectionViewCellDidTapFavorite(self)
    }
    
    @objc private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard gesture.state == .ended else { return }
        delegate?.customCollectionViewCellDidSwipeToDelete(self)
    }
}
