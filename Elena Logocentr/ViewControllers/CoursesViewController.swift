//
//  CoursesViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 14/12/2025.
//

import UIKit

class CoursesViewController: UIViewController {

    // MARK: - UI Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Courses Screen"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
