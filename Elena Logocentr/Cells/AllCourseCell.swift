//
//  AllCourseCell.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 27/12/2025.
//

import UIKit

class AllCourseCell: UICollectionViewCell {
    
    static let identifier = "AllCourseCell"
    
    // MARK: - UI Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
