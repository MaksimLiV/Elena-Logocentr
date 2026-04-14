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
    func didSwipeToDelete(at indexPath: IndexPath)
}

extension AllCourseCellDelegate {
    func didSwipeToDelete(at indexPath: IndexPath) {}
}

class AllCourseCell: UICollectionViewCell {
    
    static let identifier = "AllCourseCell"
    
    // MARK: - Properties
    
    weak var delegate: AllCourseCellDelegate?
    private var indexPath: IndexPath?
    
    // MARK: - Swipe Properties
    
    private var panGesture: UIPanGestureRecognizer!
    private var tapGesture: UITapGestureRecognizer!
    private let deleteThreshold: CGFloat = 80
    private var isRevealed = false
    
    // MARK: - UI Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let deleteButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    private let deleteIconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "trash.fill"))
        iv.tintColor = .systemRed
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
        setupSwipeGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.transform = .identity
        deleteButtonView.alpha = 0
        isRevealed = false
        tapGesture.isEnabled = false
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
        
        contentView.addSubview(deleteButtonView)
        deleteButtonView.addSubview(deleteIconImageView)
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
            favoriteButton.heightAnchor.constraint(equalToConstant: 44),
            
            deleteButtonView.topAnchor.constraint(equalTo: containerView.topAnchor),
            deleteButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            deleteButtonView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            deleteButtonView.widthAnchor.constraint(equalToConstant: 80),
            
            deleteIconImageView.centerXAnchor.constraint(equalTo: deleteButtonView.centerXAnchor),
            deleteIconImageView.centerYAnchor.constraint(equalTo: deleteButtonView.centerYAnchor),
            deleteIconImageView.widthAnchor.constraint(equalToConstant: 24),
            deleteIconImageView.heightAnchor.constraint(equalToConstant: 24)
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
    
    private func setupSwipeGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delegate = self
        containerView.addGestureRecognizer(panGesture)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.isEnabled = false
        tapGesture.delegate = self
        contentView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    
    @objc private func favoriteButtonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.didTapFavoriteButton(at: indexPath)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: contentView)
        
        switch gesture.state {
        case .began:
            break
            
        case .changed:
            if isRevealed {
                
                let extra = min(0, translation.x)
                containerView.transform = CGAffineTransform(translationX: -deleteThreshold + extra, y: 0)
            } else {
                
                let newX = max(-deleteThreshold, min(0, translation.x))
                containerView.transform = CGAffineTransform(translationX: newX, y: 0)
                let progress = min(abs(newX) / deleteThreshold, 1.0)
                deleteButtonView.alpha = progress
            }
            
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: contentView)
            let isFastSwipe = velocity.x < -800
            
            if isRevealed {
                
                let movedEnough = translation.x < -deleteThreshold
                if movedEnough || isFastSwipe {
                    deleteCell()
                } else {
                    closeCell()
                }
            } else {
                
                if isFastSwipe {
                    
                    deleteCell()
                } else if translation.x < -deleteThreshold / 2 {
                    
                    revealCell()
                } else {
                    
                    closeCell()
                }
            }
            
        default:
            break
        }
    }
    
    private func revealCell() {
        isRevealed = true
        tapGesture.isEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = CGAffineTransform(translationX: -self.deleteThreshold, y: 0)
            self.deleteButtonView.alpha = 1
        }
    }
    
    private func closeCell() {
        isRevealed = false
        tapGesture.isEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
            self.deleteButtonView.alpha = 0
        }
    }
    
    private func deleteCell() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform(translationX: -self.bounds.width, y: 0)
            self.deleteButtonView.alpha = 0
        }) { _ in
            guard let indexPath = self.indexPath else { return }
            self.delegate?.didSwipeToDelete(at: indexPath)
        }
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        closeCell()
    }
    
    // MARK: - Public Methods
    
    var isCurrentlyRevealed: Bool { isRevealed }
    
    func closeIfRevealed() {
        guard isRevealed else { return }
        closeCell()
    }
    
    func setSwipeEnabled(_ enabled: Bool) {
        panGesture.isEnabled = enabled
    }
    
    // MARK: - Configuration
    
    func configure(with course: CourseModel, at indexPath: IndexPath, showFavoriteButton: Bool = true) {
        self.indexPath = indexPath
        imageView.image = UIImage(named: course.imageName)
        titleLabel.text = course.title
        lessonsLabel.text = course.formattedLessons
        priceLabel.text = course.formattedPrice
        favoriteButton.setFavorite(course.isFavorite)
        favoriteButton.isHidden = !showFavoriteButton
    }
}

// MARK: - UIGestureRecognizerDelegate

extension AllCourseCell: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let pan = gestureRecognizer as? UIPanGestureRecognizer else { return true }
        let velocity = pan.velocity(in: contentView)
        return abs(velocity.x) > abs(velocity.y)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer == tapGesture && isRevealed
    }
}
