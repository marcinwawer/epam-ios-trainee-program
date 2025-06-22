//
//  ViewController.swift
//  ImageDisplay
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private let padding: CGFloat = 20
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = true
        sv.alwaysBounceHorizontal = true
        sv.alwaysBounceVertical = true
        sv.minimumZoomScale = 0.1
        sv.maximumZoomScale = 3
        
        return sv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "dots"))
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerImage()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
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
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.bounds.size
        
        let scaledImageWidth = imageSize.width * scrollView.zoomScale
        let scaledImageHeight = imageSize.height * scrollView.zoomScale
        
        let horizontalInset = max((scrollViewSize.width - scaledImageWidth) / 2, 0)
        let verticalInset = max((scrollViewSize.height - scaledImageHeight) / 2, 0)
        
        let offsetX: CGFloat
        if scaledImageWidth > scrollViewSize.width {
            offsetX = (scaledImageWidth - scrollViewSize.width) / 2
        } else {
            offsetX = -horizontalInset
        }
        
        let offsetY: CGFloat
        if scaledImageHeight > scrollViewSize.height {
            offsetY = (scaledImageHeight - scrollViewSize.height) / 2
        } else {
            offsetY = -verticalInset
        }
        
        let newContentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        )
        
        let newContentOffset = CGPoint(x: offsetX, y: offsetY)
        
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset = newContentInset
            self.scrollView.contentOffset = newContentOffset
        }
        
//        disabling scrolling on horizontal axis, when whole image fit into the screen but veritcal still allowed
        scrollView.alwaysBounceHorizontal = scaledImageWidth > scrollViewSize.width
    }
}

#Preview {
    ViewController()
}
