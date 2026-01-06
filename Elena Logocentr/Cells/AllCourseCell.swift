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
        view.layer.cornerRadius = 20
        
        //Shadow setting
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lessonsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton = UIButton.createFavoriteButton()
    
    // MARK: - StackViews
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            lessonsLabel,
            createSpacer(),
            priceLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            textStackView,
            favoriteButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            // containerView занимает всю ячейку
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            

            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Размер favoriteButton
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          
          containerView.layer.shadowPath = UIBezierPath(
              roundedRect: containerView.bounds,
              cornerRadius: 20
          ).cgPath
      }
    
    // MARK: - Helper Methods
    
    private func createSpacer() -> UIView {
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        spacer.translatesAutoresizingMaskIntoConstraints = false
        return spacer
    }
    
    // MARK: - Configuration
    
    func configure(with course: Course) {
        imageView.image = UIImage(named: course.imageName)
        titleLabel.text = course.title
        lessonsLabel.text = course.formattedLessons
        priceLabel.text = course.formattedPrice
        
        favoriteButton.setFavorite(course.isFavorite)
    }
}
