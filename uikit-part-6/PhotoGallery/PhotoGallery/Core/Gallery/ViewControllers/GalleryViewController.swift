//
//  GalleryViewController.swift
//  PhotoGallery
//
//  Created by Marcin Wawer on 29-06-2025.
//

import UIKit

class GalleryViewController: UIViewController {
    
    let vm = GalleryViewModel()
    
    private var images = DeveloperPreview.shared.images
    private let defaultSpacing: CGFloat = 4
    private let headerSpacing: CGFloat = 16
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.register(DateSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DateSectionHeader.reuseIdentifier)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
    
    private func setupView() {
        title = "Gallery"
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    private func loadData() {
        let sample = DeveloperPreview.shared.images
        vm.load(images: sample)
        collectionView.reloadData()
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.sections[section].images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("failed to deque CustomCollectionViewCell in GalleryViewController")
        }
        
        let item = vm.sections[indexPath.section].images[indexPath.row]
        cell.configure(with: item)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: DateSectionHeader.reuseIdentifier,
            for: indexPath
        ) as? DateSectionHeader
        else {
            return UICollectionReusableView()
        }
        
        let date = vm.sections[indexPath.section].date
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        let dayString = dayFormatter.string(from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter.string(from: date)
        
        header.configure(day: dayString, date: dateString)
        return header
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isLandscape = collectionView.bounds.width > collectionView.bounds.height
        let itemsPerRow: CGFloat = isLandscape ? 5 : 3
        
        let insets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        
        let totalSpacing = defaultSpacing * (itemsPerRow - 1) + insets.right + insets.left
        let availableWidth = collectionView.bounds.width - totalSpacing
        let size = floor(availableWidth / itemsPerRow)
        
        return CGSize(width: size, height: size * 1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        defaultSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        defaultSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: defaultSpacing, left: defaultSpacing, bottom: headerSpacing, right: defaultSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
}

extension GalleryViewController: CustomCollectionViewCellDelegate {
    
    func customCollectionViewCellDidTapFavorite(_ cell: CustomCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        vm.toggleFavorite(indexPath: indexPath)
        collectionView.reloadItems(at: [indexPath])
        
        let updateImage = vm.ImageModel(indexPath: indexPath)
        
        let message: String
        if updateImage.isFavorite {
            message = "Marked \(updateImage.title) as Favorite! ❤️"
        } else {
            message = "Removed \(updateImage.title) from Favorites. 💔"
        }
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func customCollectionViewCellDidSwipeToDelete(_ cell: CustomCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let imageTitle = vm.sections[indexPath.section].images[indexPath.row].title
        
        let isLastInSection = vm.sections[indexPath.section].images.count == 1

        let alert = UIAlertController(
            title: "Delete Image",
            message: "Are you sure you want to delete '\(imageTitle)'? 😭",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.vm.removeImage(at: indexPath)
            
            self.collectionView.performBatchUpdates({
                if isLastInSection {
                    self.collectionView.deleteSections(IndexSet(integer: indexPath.section))
                } else {
                    self.collectionView.deleteItems(at: [indexPath])
                }
            })
        })
        
        present(alert, animated: true)
    }
}
