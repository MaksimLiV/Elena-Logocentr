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
    
    // MARK: - Top Courses Section / Horizontal collection view
    
    private lazy var topCoursesLabel: UILabel = {
        let label = UILabel()
        label.text = "Топ курсы"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topCoursesCollectionView: UICollectionView = {
        let layout = createTopCoursesLayout()
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
    
    // MARK: - Vertical collection view
    
    private lazy var allCoursesLabel: UILabel = {
       let label = UILabel()
        label.text = "Все курсы"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.title = "Показать все"
        config.image = UIImage(systemName: "chevron.right")
        config.imagePlacement = .trailing
        config.imagePadding = 4
        
        button.configuration = config
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var allCoursesHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            allCoursesLabel,
            createSpacer(),
            seeAllButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var allCoursesCollectionView: SelfSizingCollectionView = {
        let layout = createAllCoursesLayout()
        let collectionView = SelfSizingCollectionView(frame: .zero, collectionViewLayout: layout)
        
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
    
    private lazy var allCoursesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            allCoursesHeaderStackView,
            allCoursesCollectionView
        ])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Data
    
    private var topCourses = Course.sampleData
    private var allCourses = Course.sampleData
    
    // MARK: - Lifecycle
    
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
    
    private func setupNavigationBar() {
        title = "Главная"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        favoriteButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = favoriteButton
    }
 
    private var didLayoutOnce = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didLayoutOnce {
            topCoursesCollectionView.collectionViewLayout.invalidateLayout()
            allCoursesCollectionView.collectionViewLayout.invalidateLayout()
            didLayoutOnce = true
        }
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        mainStackView.addArrangedSubview(topCoursesStackView)
        mainStackView.addArrangedSubview(allCoursesStackView)
        
        contentView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
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
    
    private func createTopCoursesLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }
    
    private func createAllCoursesLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    // MARK: - Actions
    
    @objc private func favoriteButtonTapped() {
        let favoritesVC = FavoritesViewController()
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
    
    @objc private func seeAllButtonTapped() {
        let seeAllVC = SeeAllViewController()
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == topCoursesCollectionView {
            return topCourses.count
        } else if collectionView == allCoursesCollectionView {
            return allCourses.count
        }
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        // TopCourses
        if collectionView == topCoursesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TopCourseCell.identifier,
                for: indexPath
            ) as? TopCourseCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: topCourses[indexPath.item])
            return cell
        }
        
        // AllCourses
        else if collectionView == allCoursesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AllCourseCell.identifier,
                for: indexPath
            ) as? AllCourseCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: allCourses[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if collectionView == topCoursesCollectionView {
            // TODO: Переход на детали топ курса
        } else if collectionView == allCoursesCollectionView {
            // TODO: Переход на детали курса
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        // TopCourses (horizontal, full screen)
        if collectionView == topCoursesCollectionView {
            return CGSize(
                width: collectionView.frame.width,
                height: collectionView.frame.height
            )
        }
        
        // AllCourses (vertical, list)
        else if collectionView == allCoursesCollectionView {
            let width = collectionView.frame.width
            let height: CGFloat = 104
            return CGSize(width: width, height: height)
        }
        
        return CGSize.zero
    }
}
