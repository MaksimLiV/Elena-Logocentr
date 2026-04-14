//
//  FavoritesViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 20/12/2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    
    private var favoriteCourses: [CourseModel] = []
    var onFavoritesChanged: (() -> Void)?
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(AllCourseCell.self, forCellWithReuseIdentifier: AllCourseCell.identifier)
        
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    // MARK: - UI Components - Empty State
    
    private let emptyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "No favorite courses"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptySubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add courses to favorites,\n so they appear here"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            emptyTitleLabel,
            emptySubtitleLabel
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var emptyStateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        
        view.addSubview(collectionView)
        
        emptyStateView.addSubview(emptyStackView)
        view.addSubview(emptyStateView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStackView.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            emptyStackView.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor),
            
            emptyStackView.leadingAnchor.constraint(greaterThanOrEqualTo: emptyStateView.leadingAnchor, constant: 40),
            emptyStackView.trailingAnchor.constraint(lessThanOrEqualTo: emptyStateView.trailingAnchor, constant: -40)
        ])
    }
    
    // MARK: - Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let width = UIScreen.main.bounds.width - 32
        let height: CGFloat = 104
        layout.itemSize = CGSize(width: width, height: height)
        
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 8
        
        return layout
    }
    
    // MARK: - Data Loading
    
    private func loadFavorites() {
        favoriteCourses = CourseModel.favorites
        updateUI()
    }
    
    private func updateUI() {
        let isEmpty = favoriteCourses.isEmpty
        
        UIView.animate(withDuration: 0.3) {
            self.emptyStateView.alpha = isEmpty ? 1.0 : 0.0
            self.collectionView.alpha = isEmpty ? 0.0 : 1.0
        } completion: { _ in
            self.emptyStateView.isHidden = !isEmpty
            self.collectionView.isHidden = isEmpty
        }
        
        if !isEmpty {
            collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteCourses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AllCourseCell.identifier,
            for: indexPath
        ) as? AllCourseCell else {
            return UICollectionViewCell()
        }
        
        let course = favoriteCourses[indexPath.item]
        cell.delegate = self
        cell.configure(with: course, at: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FavoritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCourse = favoriteCourses[indexPath.item]
        let detailVC = CourseDetailViewController(course: selectedCourse)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - AllCourseCellDelegate

extension FavoritesViewController: AllCourseCellDelegate {
    
    func didTapFavoriteButton(at indexPath: IndexPath) {
        guard indexPath.item < favoriteCourses.count else { return }
        
        let course = favoriteCourses[indexPath.item]
        
        guard let mainIndex = CourseModel.findIndex(byTitle: course.title) else { return }
        
        CourseModel.toggleFavorite(at: mainIndex)
        onFavoritesChanged?()
        
        favoriteCourses = CourseModel.favorites
        
        if favoriteCourses.isEmpty {
            collectionView.reloadData()
            updateUI()
        } else {
            collectionView.reloadData()
        }
    }
}
