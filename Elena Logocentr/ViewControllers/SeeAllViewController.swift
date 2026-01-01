//
//  SeeAllViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 27/12/2025.
//

import UIKit

class SeeAllViewController: UIViewController {

    // MARK: - UI Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "All courses"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        setupUI()
    }
    
    // MARK: - Setup
     
     private func setupUI() {
         view.backgroundColor = .systemBackground
         
         view.addSubview(titleLabel)
         
         setupConstraints()
     }
     
     private func setupConstraints() {
         NSLayoutConstraint.activate([
             titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
         ])
     }

}
