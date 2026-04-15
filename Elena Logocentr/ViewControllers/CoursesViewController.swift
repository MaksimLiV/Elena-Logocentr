//
//  CoursesViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 14/12/2025.
//

import UIKit

class CoursesViewController: UIViewController {
    
    // MARK: - Properties
    private var purchasedCourses: [CourseModel] = []
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - UI Components - Empty State
    
    private let emptyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "No Enrolled Courses"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptySubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Buy courses,\nso they appear here"
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
        collectionView.register(AllCourseCell.self, forCellWithReuseIdentifier: AllCourseCell.identifier)
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCollectionViewTap))
        tap.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPurchasedCourses()
        collectionView.reloadData()
    }
    
    // MARK: - Data Loading
    private func loadPurchasedCourses() {
        purchasedCourses = CourseModel.shared.filter{$0.isPurchased}
        print("Purchased courses loaded: \(purchasedCourses.count)")
        updateEmptyState()
    }
    
    private func updateEmptyState() {
        let isEmpty = purchasedCourses.isEmpty
        emptyStateView.isHidden = !isEmpty
        collectionView.isHidden = isEmpty
    }
    
    private func deleteCourse(at indexPath: IndexPath) {
        print("Deleting course: \(purchasedCourses[indexPath.item].title)")
    }
    
    // MARK: - Actions
    
    @objc private func handleCollectionViewTap() {
        for cell in collectionView.visibleCells {
            (cell as? AllCourseCell)?.closeIfRevealed()
        }
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "My Enrolled Courses"
        
        view.addSubview(collectionView)
        emptyStateView.addSubview(emptyStackView)
        view.addSubview(emptyStateView)
        setupConstraints()
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
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
    
}

// MARK: - UICollectionViewDataSource
extension CoursesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return purchasedCourses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AllCourseCell.identifier,
            for: indexPath
        ) as? AllCourseCell else {
            return UICollectionViewCell()
        }
        
        let course = purchasedCourses[indexPath.item]
        cell.configure(with: course, at: indexPath, showFavoriteButton: false)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CoursesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCourse = purchasedCourses[indexPath.item]
        let detailVC = CourseDetailViewController(course: selectedCourse)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CoursesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 104)
    }
}

// MARK: - AllCourseCellDelegate
extension CoursesViewController: AllCourseCellDelegate {
    
    func didTapFavoriteButton(at indexPath: IndexPath) {
        // используется в других экранах
    }
    
    func didSwipeToDelete(at indexPath: IndexPath) {
        guard purchasedCourses.indices.contains(indexPath.item) else { return }
        
        let course = purchasedCourses[indexPath.item]
        
        if let globalIndex = CourseModel.findIndex(byTitle: course.title) {
            CourseModel.shared[globalIndex].isPurchased = false
            
            let lockedLessons = CourseModel.shared[globalIndex].lessonsList.map { lesson in
                if lesson.status != .locked {
                    return Lesson(title: lesson.title, duration: lesson.duration, status: .locked)
                }
                return lesson
            }
            CourseModel.shared[globalIndex].lessonsList = lockedLessons
            CourseModel.saveCourses()
        }
        
        purchasedCourses.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
        updateEmptyState()
    }
}
