//
//  AllCourseCell.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 27/12/2025.
//

import UIKit

// MARK: - Delegate Protocol

protocol AllCourseCellDelegate: AnyObject {
    func didTapFavoriteButton(at indexPath: IndexPath)
}

class AllCourseCell: UICollectionViewCell {
    
    static let identifier = "AllCourseCell"
    
    // MARK: - Properties

    weak var delegate: AllCourseCellDelegate?
    private var indexPath: IndexPath?
    
    // MARK: - UI Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lessonsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton = UIButton.createFavoriteButton()
    
    private lazy var textStackView: UIStackView = {
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            lessonsLabel,
            spacer,
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
        configureShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        lessonsLabel.text = nil
        priceLabel.text = nil
        favoriteButton.setFavorite(false)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.clipsToBounds = false
        clipsToBounds = false
        
        contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        imageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            imageView.widthAnchor.constraint(equalToConstant: 80),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    private func configureShadows() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        containerView.layer.shadowRadius = 8
        containerView.layer.masksToBounds = false
    }
    
    // MARK: - Actions
    
    @objc private func favoriteButtonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.didTapFavoriteButton(at: indexPath)
    }
    
    // MARK: - Configuration
    
    func configure(with course: CourseManager, at indexPath: IndexPath) {
        self.indexPath = indexPath
        imageView.image = UIImage(named: course.imageName)
        titleLabel.text = course.title
        lessonsLabel.text = course.formattedLessons
        priceLabel.text = course.formattedPrice
        favoriteButton.setFavorite(course.isFavorite)
    }
}
