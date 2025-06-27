//
//  HomeViewController.swift
//  GymScheduleApp
//
//  Created by Marcin Wawer on 27-06-2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    let vm = HomeViewModel()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        loadData()
    }
    
    private func setupView() {
        self.title = "Wellness Classes"
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(GymClassCell.self, forCellReuseIdentifier: GymClassCell.identifier)
        tableView.register(DateHeaderView.self, forHeaderFooterViewReuseIdentifier: DateHeaderView.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func deleteClass(indexPath: IndexPath) {
        vm.deleteClass(indexPath: indexPath)
        
        if vm.sections[indexPath.section].classes.isEmpty {
            vm.sections.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func loadData() {
        let sample = DeveloperPreview.shared.gymClasses
        vm.load(classes: sample)
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.sections[section].classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gymClass = vm.gymClass(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GymClassCell.identifier, for: indexPath) as? GymClassCell else {
            return UITableViewCell()
        }
        
        cell.configure(gymClass: gymClass)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DateHeaderView.identifier) as? DateHeaderView else {
            return nil
        }
        
        let date = vm.sections[section].date
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        header.dayLabel.text = dayFormatter.string(from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        header.dateLabel.text = dateFormatter.string(from: date)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let gymClass = vm.gymClass(indexPath: indexPath)
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
            guard let self = self else {
                completion(false)
                return
            }
            
            if gymClass.isRegistered {
                self.showAlert(message: "You cannot delete a class that you are registered for 🤯")
                completion(false)
            } else {
                self.deleteClass(indexPath: indexPath)
                completion(true)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension HomeViewController: GymClassCellDelegate {
    
    func gymClassCell(_ cell: GymClassCell, didTapRegisterFor gymClass: GymClass) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        vm.toggleRegistration(indexPath: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        let updatedClass = vm.gymClass(indexPath: indexPath)
        
        let message: String
        if updatedClass.isRegistered {
            message = "You have registered to \(updatedClass.name), see you there!"
        } else {
            message = "You have just cancelled \(updatedClass.name) :("
        }
        
        showAlert(message: message)
    }
    
    func gymClassCell(_ cell: GymClassCell, didTapFavoriteFor gymClass: GymClass) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        vm.toggleFavorite(indexPath: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        let updatedClass = vm.gymClass(indexPath: indexPath)
        
        let message: String
        if updatedClass.isFavorite {
            message = "\(updatedClass.name) added to favorites ❤️"
        } else {
            message = "\(updatedClass.name) removed from favorites 💔"
        }
        
        showAlert(message: message)
    }
}
