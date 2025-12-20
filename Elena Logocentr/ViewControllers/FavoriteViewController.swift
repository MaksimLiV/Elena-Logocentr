//
//  FavoriteViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 20/12/2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    
     // MARK: - UI Properties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup
        
        private func setupUI() {
            view.backgroundColor = .systemBackground
            title = "Избранное"
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
            ])
        }
    }
