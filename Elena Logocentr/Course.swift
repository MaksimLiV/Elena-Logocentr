//
//  Course.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 27/12/2025.
//

import Foundation

// MARK: - Model

struct Course {
    let imageName: String
    let title: String
    let lessons: Int
    let price: Double
    var isFavorite: Bool
}

// MARK: - Computed Properties

extension Course {
    
    var formattedPrice: String {
        return "Цена: \(String(format: "%.2f", price)) $"
    }
    
    var formattedLessons: String {
        return "\(lessons) \(lessonsWord)"
    }
    
    private var lessonsWord: String {
        let n = lessons
        switch n % 10 {
        case 1 where n % 100 != 11:
            return "урок"
        case let value where (2...4).contains(value) && !(12...14).contains(n % 100):
            return "урока"
        default:
            return "уроков"
        }
    }
}

// MARK: - Sample Data

extension Course {
    static let sampleData: [Course] = [
        Course(
            imageName: "course1",
            title: "3D Design Basic",
            lessons: 24,
            price: 24.99,
            isFavorite: false
        ),
        Course(
            imageName: "course2",
            title: "Characters Animation",
            lessons: 22,
            price: 22.69,
            isFavorite: false
        ),
        Course(
            imageName: "course3",
            title: "iOS Development",
            lessons: 30,
            price: 29.99,
            isFavorite: false
        ),
        Course(
            imageName: "course4",
            title: "Graphic Design Pro",
            lessons: 18,
            price: 19.99,
            isFavorite: false
        ),
        Course(
            imageName: "course5",
            title: "Video Editing Master",
            lessons: 25,
            price: 27.49,
            isFavorite: false
        )
    ]
}
