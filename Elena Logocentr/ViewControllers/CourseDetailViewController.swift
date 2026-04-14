//
//  CourseDetailViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 11/02/2026.
//

import UIKit

class CourseDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let courseTitle: String
    
    private var course: CourseModel {
        guard let index = CourseModel.findIndex(byTitle: courseTitle) else {
            fatalError("Course not found: \(courseTitle)")
        }
        return CourseModel.shared[index]
    }
    
    private var lessons: [Lesson] {
        return course.lessonsList
    }
    
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
    
    // MARK: - Init
    
    init(course: CourseModel) {
        self.courseTitle = course.title
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CourseDetailsCell.self, forCellWithReuseIdentifier: CourseDetailsCell.identifier)
        collectionView.register(LessonCell.self, forCellWithReuseIdentifier: LessonCell.identifier)
        collectionView.register(EnrollButtonCell.self, forCellWithReuseIdentifier: EnrollButtonCell.identifier)
        
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = course.title
        collectionView.reloadData()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = course.title
        
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }
}

// MARK: - UICollectionViewDataSource

extension CourseDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return lessons.count
        case 2:
            return course.isPurchased ? 0 : 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CourseDetailsCell.identifier,
                for: indexPath
            ) as? CourseDetailsCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: course)
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LessonCell.identifier,
                for: indexPath
            ) as? LessonCell else {
                return UICollectionViewCell()
            }
            
            let lesson = lessons[indexPath.item]
            cell.configure(with: lesson)
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EnrollButtonCell.identifier,
                for: indexPath
            ) as? EnrollButtonCell else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            cell.configure(with: course.price)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CourseDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width - 32
        
        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: 350)
            
        case 1:
            return CGSize(width: width, height: 70)
            
        case 2:
            return CGSize(width: width, height: 56)
            
        default:
            return .zero
        }
    }
}

// MARK: - UICollectionViewDelegate

extension CourseDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        
        toggleLessonStatus(at: indexPath.item)
    }
}

// MARK: - EnrollButtonCellDelegate

extension CourseDetailViewController: EnrollButtonCellDelegate {
    func didTapEnrollButton(price: Double) {
        let alert = UIAlertController (
            title: "Purchase Course",
            message: "Are you sure you want to buy this course for $\(String(format: "%.2f", price))?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let buyAction = UIAlertAction(title: "Buy", style: .default) { [weak self] _ in
            self?.purchaseCourse()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(buyAction)
        
        present(alert, animated: true)
    }
    
    private func purchaseCourse() {
        guard let index = CourseModel.findIndex(byTitle: course.title) else {
            print("Course didn't found")
            return
        }
        
        CourseModel.shared[index].isPurchased = true
        
        let updateLessons = CourseModel.shared[index].lessonsList.map { lesson in
            if lesson.status == .locked {
                return Lesson(title: lesson.title, duration: lesson.duration, status: .available)
            }
            return lesson
            
        }
        CourseModel.shared[index].lessonsList = updateLessons
        
        CourseModel.saveCourses()
        showSuccessAlert()
        collectionView.reloadData()
    }
    
    private func showSuccessAlert() {
        let alert = UIAlertController(
            title: "Success",
            message: "You've purchased the course! You can find it in the Courses section",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func toggleLessonStatus(at lessonIndex: Int) {
        // 1. Находим курс в глобальном массиве
        guard let courseIndex = CourseModel.findIndex(byTitle: courseTitle) else {
            print("Course didn't found")
            return
        }
        
        // 2. Находим курс в глобальном
        let currentLesson = CourseModel.shared[courseIndex].lessonsList[lessonIndex]
        
        // 3. Меняем статус в зависимости от текущего
        let newStatus: LessonStatus
        
        switch currentLesson.status {
        case .locked:
            // Заблокированный урок - ничего не делаем
            print("Course is blocked!")
            return
            
        case .available:
            // Доступный → Выполненный
            newStatus = .completed
            print("Lesson marked as completed")
            
        case .completed:
            // Выполненный → Доступный
            newStatus = .available
            print("Completion mark removed")
        }
        
        // 4. Создаём обновлённый урок
        let updatedLesson = Lesson (
            title: currentLesson.title,
            duration: currentLesson.duration,
            status: newStatus
        )
        
        // 5. Обновляем урок в массиве
        CourseModel.shared[courseIndex].lessonsList[lessonIndex] = updatedLesson
        
        // 6. Сохраняем изменения
        CourseModel.saveCourses()
        
        // 7. Обновляем UI
        let indexPath = IndexPath(item: lessonIndex, section: 1)
        collectionView.reloadItems(at: [indexPath])
        
        
    }
}
