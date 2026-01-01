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
        return String(format: "$%.2f", price)
    }
    
    var formattedLessons: String {
        return "\(lessons) lessons"
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
