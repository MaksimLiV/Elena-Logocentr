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
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Top Courses Section
    
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
        collectionView.register(
            TopCourseCell.self,
            forCellWithReuseIdentifier: TopCourseCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - All Courses
    
    private lazy var allCoursesLabel: UILabel = {
        let label = UILabel()
        label.text = "Все курсы"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var allCoursesLabelContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var allCoursesCollectionView: SelfSizingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = SelfSizingCollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            AllCourseCell.self,
            forCellWithReuseIdentifier: AllCourseCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Data
    
    private var topCourses: [CourseManager] {
        CourseManager.shared
    }
    
    private var allCourses: [CourseManager] {
        CourseManager.shared
    }
    
    // MARK: - Lifecycle
    
    private var didLayoutOnce = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        
        let (scroll, content) = setupScrollableContent()
        self.scrollView = scroll
        self.contentView = content
        
        setupUI()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didLayoutOnce {
            topCoursesCollectionView.collectionViewLayout.invalidateLayout()
            allCoursesCollectionView.collectionViewLayout.invalidateLayout()
            didLayoutOnce = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        topCoursesCollectionView.reloadData()
        allCoursesCollectionView.reloadData()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        title = "Главная"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        favoriteButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    private func setupUI() {
        allCoursesLabelContainer.addSubview(allCoursesLabel)
        
        NSLayoutConstraint.activate([
            allCoursesLabel.topAnchor.constraint(equalTo: allCoursesLabelContainer.topAnchor),
            allCoursesLabel.leadingAnchor.constraint(equalTo: allCoursesLabelContainer.leadingAnchor, constant: 10),
            allCoursesLabel.trailingAnchor.constraint(equalTo: allCoursesLabelContainer.trailingAnchor),
            allCoursesLabel.bottomAnchor.constraint(equalTo: allCoursesLabelContainer.bottomAnchor)
        ])
        
        mainStackView.addArrangedSubview(topCoursesCollectionView)
        mainStackView.addArrangedSubview(allCoursesLabelContainer)
        mainStackView.addArrangedSubview(allCoursesCollectionView)
        
        contentView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            topCoursesCollectionView.heightAnchor.constraint(
                equalTo: topCoursesCollectionView.widthAnchor,
                multiplier: 9.0 / 16.0
            )
        ])
    }
    
    // MARK: - Actions
    
    @objc private func favoriteButtonTapped() {
        let favoritesVC = FavoritesViewController()
        
        favoritesVC.onFavoritesChanged = { [weak self] in
            guard let self else { return }
            let visibleIndexPaths = self.allCoursesCollectionView.indexPathsForVisibleItems
            self.allCoursesCollectionView.reloadItems(at: visibleIndexPaths)
        }
        
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == topCoursesCollectionView ? topCourses.count : allCourses.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        if collectionView == topCoursesCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TopCourseCell.identifier,
                for: indexPath
            ) as! TopCourseCell
            cell.configure(with: topCourses[indexPath.item])
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AllCourseCell.identifier,
            for: indexPath
        ) as! AllCourseCell
        cell.delegate = self
        cell.configure(with: allCourses[indexPath.item], at: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        if collectionView == topCoursesCollectionView {
            return CGSize(width: collectionView.frame.width,
                          height: collectionView.frame.height)
        }
        
        return CGSize(width: collectionView.frame.width, height: 104)
    }
}

// MARK: - AllCourseCellDelegate

extension HomeViewController: AllCourseCellDelegate {
    
    // ✅ УЛУЧШЕНО: Обновление всех мест, где показывается курс
    func didTapFavoriteButton(at indexPath: IndexPath) {
        guard indexPath.item < allCourses.count else { return }
        
        // ✅ Переключаем избранное (автоматически сохраняется в UserDefaults)
        CourseManager.toggleFavorite(at: indexPath.item)
        
        // ✅ Обновляем конкретную ячейку для плавной анимации
        allCoursesCollectionView.reloadItems(at: [indexPath])
        
        // ✅ Также обновляем top courses на случай, если там показана та же карточка
        if let topIndex = topCourses.firstIndex(where: { $0.title == allCourses[indexPath.item].title }) {
            topCoursesCollectionView.reloadItems(at: [IndexPath(item: topIndex, section: 0)])
        }
    }
}
