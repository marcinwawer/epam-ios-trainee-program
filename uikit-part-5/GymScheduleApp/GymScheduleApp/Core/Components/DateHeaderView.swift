//
//  DateHeaderView.swift
//  GymScheduleApp
//
//  Created by Marcin Wawer on 27-06-2025.
//

import UIKit

class DateHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "DateHeaderView"
    
    let dateLabel = UILabel()
    let dayLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemGray6
        
        dayLabel.font = UIFont.boldSystemFont(ofSize: 24)
        dayLabel.textColor = .black
        
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        dateLabel.textColor = .secondaryAccent
        
        let stack = UIStackView(arrangedSubviews: [dayLabel, dateLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
