//
//  HomeViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 10/12/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Header Section
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, Maksim!"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let image = UIImage(systemName: "heart.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            greetingLabel,
            createSpacer(),
            favoriteButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Top Courses Section / Horizontal collection view
    
    private lazy var topCoursesLabel: UILabel = {
        let label = UILabel()
        label.text = "Топ курсы"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topCoursesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TopCourseCell.self, forCellWithReuseIdentifier: TopCourseCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var topCoursesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topCoursesLabel,
            topCoursesCollectionView
        ])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Data
    
    private let topCourses: [String] = [
        "course1",
        "course2",
        "course3",
        "course4",
        "course5"
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let (scroll, content) = setupScrollableContent()
        self.scrollView = scroll
        self.contentView = content
        
        setupUI()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topCoursesCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        mainStackView.addArrangedSubview(headerStackView)
        mainStackView.addArrangedSubview(topCoursesStackView)
    
        contentView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -20),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10
                                                 ),
            
            topCoursesCollectionView.heightAnchor.constraint(
                equalTo: topCoursesCollectionView.widthAnchor,
                multiplier: 9.0 / 16.0
            )
        ])
    }
    
    // MARK: - Helper Methods
    
    private func createSpacer() -> UIView {
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer.translatesAutoresizingMaskIntoConstraints = false
        return spacer
    }
    
    // MARK: - Actions
    
    @objc private func favoriteButtonTapped() {
        let favoritesVC = FavoritesViewController()
        navigationController?.pushViewController(favoritesVC, animated: true)
        
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topCourses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopCourseCell.identifier,
            for: indexPath
        ) as! TopCourseCell
        
        cell.configure(with: topCourses[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { // -> нужен для того когда в будущем буду нажимать на баннер чтобы переходил на курс
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
