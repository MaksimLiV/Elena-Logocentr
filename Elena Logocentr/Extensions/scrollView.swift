//
//  scrollView.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 07/12/2025.
//

import UIKit

extension UIViewController {
    
    // MARK: - Scrollable Content Setup
    
    func setupScrollableContent() -> (scrollView: UIScrollView, contentView: UIView) {
        // Create ScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.keyboardDismissMode = .onDrag
        
        // Create ContentView
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add to hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // ScrollView constraints (to main view)
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView constraints (to scrollView)
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Width constraint - prevents horizontal scrolling
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        return (scrollView, contentView)
    }
    
    // MARK: - Keyboard Handling
    
    func setupKeyboardHandling(for scrollView: UIScrollView) {
        // Save scrollView reference using associated objects
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.scrollView,
            scrollView,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
        
        // Add keyboard observers
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowHandler(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideHandler(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: - Private Keyboard Methods
    
    @objc private func keyboardWillShowHandler(_ notification: NSNotification) {
        guard let scrollView = objc_getAssociatedObject(self, &AssociatedKeys.scrollView) as? UIScrollView,
              let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        
        // Add bottom inset = keyboard height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc private func keyboardWillHideHandler(_ notification: NSNotification) {
        guard let scrollView = objc_getAssociatedObject(self, &AssociatedKeys.scrollView) as? UIScrollView else {
            return
        }
        
        // Remove insets
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

// MARK: - Associated Object Keys

private struct AssociatedKeys {
    static var scrollView: UInt8 = 0
}
