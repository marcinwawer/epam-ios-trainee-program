//
//  KeyboardHandler.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import UIKit

final class KeyboardHandler {
    
    private weak var viewController: UIViewController?
    private var originalY: CGFloat = 0
    private let shouldShiftViewUp: Bool
    
    init(viewController: UIViewController, shouldShiftViewUp: Bool = true) {
        self.viewController = viewController
        self.originalY = viewController.view.frame.origin.y
        self.shouldShiftViewUp = shouldShiftViewUp
        
        setupGesture()
        setupKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        viewController?.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func endEditing() {
        viewController?.view.endEditing(true)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard shouldShiftViewUp,
              let vc = viewController,
              let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        let keyboardHeight = keyboardFrame.height
        vc.view.frame.origin.y = -keyboardHeight
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard shouldShiftViewUp,
              let vc = viewController
        else { return }
        
        vc.view.frame.origin.y = originalY
    }
}
