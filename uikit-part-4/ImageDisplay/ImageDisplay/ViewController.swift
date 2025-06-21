//
//  ViewController.swift
//  ImageDisplay
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let padding: CGFloat = 20
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = true
        sv.alwaysBounceHorizontal = true
        sv.alwaysBounceVertical = true
        sv.minimumZoomScale = 0.4
        sv.maximumZoomScale = 3.0
        
        return sv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "cat"))
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.zoomScale = 0.4
        centerImage()
    }
    
    private func setupView() {
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
        
        scrollView.contentSize = imageView.bounds.size
    }
    
    private func centerImage() {
        let boundsSize = scrollView.bounds.size
        let contentSize = scrollView.contentSize
        
        let offsetX = max((contentSize.width - boundsSize.width) / 2, 0)
        let offsetY = max((contentSize.height - boundsSize.height) / 2, 0)
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: offsetY), animated: true)
    }
}

// MARK: - ZOOM
extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        centerImage()
    }
}

#Preview {
    ViewController()
}
