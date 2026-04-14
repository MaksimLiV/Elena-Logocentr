//
//  CourseManager.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 27/12/2025.
//

import Foundation

// MARK: - Lesson Status

enum LessonStatus: String, Codable {
    case locked
    case available
    case completed
}

// MARK: - Lesson Model

struct Lesson: Codable {
    let title: String
    let duration: String
    let status: LessonStatus
}

// MARK: - Course Model

struct CourseModel: Codable {
    let imageName: String
    let title: String
    let lessons: Int
    let price: Double
    var isFavorite: Bool
    let description: String
    let duration: String
    var isPurchased: Bool
    var lessonsList: [Lesson]
}

// MARK: - User Model

struct User: Codable {
    
    let name: String
    let email: String
    
    var initials: String {
        let components = name.components(separatedBy: " ")
        let initials = components.compactMap { $0.first }.prefix(2)
        return initials.map(String.init).joined().uppercased()
    }
    
    static let testEmail = "maksim@example.com"
    static let testPassword = "12345678"
    static let testName = "Maksim Li"
}

// MARK: - User Session Manager

class UserSessionManager {
    
    static let shared = UserSessionManager()
    
    private let defaults = UserDefaults.standard
    private let isLoggedInKey = "isLoggedIn"
    private let currentUserKey = "currentUser"
    
    private init() {}
    
    // MARK: Current User
    
    var currentUser: User? {
        get {
            guard let data = defaults.data(forKey: currentUserKey) else { return nil }
            
            do {
                return try JSONDecoder().decode(User.self, from: data)
            } catch {
                print("User decoding error: \(error)")
                return nil
            }
        }
        
        set {
            if let user = newValue {
                do {
                    let data = try JSONEncoder().encode(user)
                    defaults.set(data, forKey: currentUserKey)
                } catch {
                    print("User encoding error: \(error)")
                }
            } else {
                defaults.removeObject(forKey: currentUserKey)
            }
        }
    }
    
    var isLoggedIn: Bool {
        defaults.bool(forKey: isLoggedInKey)
    }
    
    func login(email: String, password: String) -> Bool {
        
        if email == User.testEmail && password == User.testPassword {
            
            let user = User(
                name: User.testName,
                email: User.testEmail
            )
            
            currentUser = user
            defaults.set(true, forKey: isLoggedInKey)
            
            print("Successful login: \(user.name)")
            return true
        }
        
        print("Invalid email or password")
        return false
    }
    
    func logout() {
        currentUser = nil
        defaults.set(false, forKey: isLoggedInKey)
        print("Logged out")
    }
}

// MARK: - Course Computed Properties

extension CourseModel {
    
    var formattedPrice: String {
        return String(format: "$%.2f", price)
    }
    
    var formattedLessons: String {
        return "\(lessons) \(lessons == 1 ? "lesson" : "lessons")"
    }
}

// MARK: - Course Management

extension CourseModel {
    
    private static let coursesKey = "savedCourses"
    
    static var shared: [CourseModel] = loadCourses()
    
    static var favorites: [CourseModel] {
        shared.filter { $0.isFavorite }
    }
    
    static func toggleFavorite(at index: Int) {
        
        guard shared.indices.contains(index) else { return }
        
        shared[index].isFavorite.toggle()
        
        print(
            shared[index].isFavorite
            ? "✅ '\(shared[index].title)' added to favorites"
            : "❌ '\(shared[index].title)' removed from favorites"
        )
        
        saveCourses()
    }
    
    static func findIndex(byTitle title: String) -> Int? {
        shared.firstIndex { $0.title == title }
    }
    
    // MARK: Save Courses
    
    static func saveCourses() {
        do {
            let data = try JSONEncoder().encode(shared)
            UserDefaults.standard.set(data, forKey: coursesKey)
            print ("Courses saved")
        } catch {
            print("Failed to save courses: \(error)")
        }
    }
    
    // MARK: Load Courses - Загружает курсы из UserDefaults или возвращает начальные данные
    
    private static func loadCourses() -> [CourseModel] {
        
        if let data = UserDefaults.standard.data(forKey: coursesKey) {
            do {
                let courses = try JSONDecoder().decode([CourseModel].self, from: data)
                print("Courses loaded from UserDefaults (\(courses.count) items)")
                return courses
            } catch {
                print ("Courses not loaded \(error)")
            }
        }
        
        print("Initial courses loaded")
        return sampleData
    }
    
    // MARK: Sample Data
    
    private static let sampleData: [CourseModel] = [
        
        CourseModel(
            imageName: "course1",
            title: "3D Design Basic",
            lessons: 6,
            price: 24.99,
            isFavorite: false,
            description: "In this course you will learn how to build a space to a 3-dimensional product. There are 24 premium learning videos for you",
            duration: "20 hours",
            isPurchased: false,
            lessonsList: [
                Lesson(title: "Lesson 1: Introduction to 3D", duration: "17 mins", status: .locked),
                Lesson(title: "Lesson 2: Basic Shapes", duration: "19 mins", status: .locked),
                Lesson(title: "Lesson 3: Modeling Tools", duration: "21 mins", status: .locked),
                Lesson(title: "Lesson 4: Materials & Textures", duration: "23 mins", status: .locked),
                Lesson(title: "Lesson 5: Lighting Basics", duration: "25 mins", status: .locked),
                Lesson(title: "Lesson 6: Rendering", duration: "27 mins", status: .locked)
            ]
        ),
        
        CourseModel(
            imageName: "course2",
            title: "Characters Animation",
            lessons: 9,
            price: 22.69,
            isFavorite: false,
            description: "Learn professional character animation techniques from industry experts. Master the art of bringing characters to life",
            duration: "18 hours",
            isPurchased: false,
            lessonsList: [
                Lesson(title: "Lesson 1: Animation Principles", duration: "17 mins", status: .locked),
                Lesson(title: "Lesson 2: Walk Cycles", duration: "19 mins", status: .locked),
                Lesson(title: "Lesson 3: Run Cycles", duration: "21 mins", status: .locked),
                Lesson(title: "Lesson 4: Jump Animation", duration: "23 mins", status: .locked),
                Lesson(title: "Lesson 5: Facial Expressions", duration: "25 mins", status: .locked),
                Lesson(title: "Lesson 6: Lip Sync", duration: "27 mins", status: .locked),
                Lesson(title: "Lesson 7: Body Mechanics", duration: "29 mins", status: .locked),
                Lesson(title: "Lesson 8: Acting & Emotion", duration: "31 mins", status: .locked),
                Lesson(title: "Lesson 9: Final Project", duration: "33 mins", status: .locked)
            ]
        ),
        
        CourseModel(
            imageName: "course3",
            title: "iOS Development",
            lessons: 7,
            price: 29.99,
            isFavorite: false,
            description: "Build amazing iOS applications from scratch. Learn Swift, UIKit, and modern iOS development practices",
            duration: "25 hours",
            isPurchased: false,
            lessonsList: [
                Lesson(title: "Lesson 1: Swift Basics", duration: "17 mins", status: .locked),
                Lesson(title: "Lesson 2: UIKit Introduction", duration: "19 mins", status: .locked),
                Lesson(title: "Lesson 3: Auto Layout", duration: "21 mins", status: .locked),
                Lesson(title: "Lesson 4: Table Views", duration: "23 mins", status: .locked),
                Lesson(title: "Lesson 5: Navigation", duration: "25 mins", status: .locked),
                Lesson(title: "Lesson 6: Networking", duration: "27 mins", status: .locked),
                Lesson(title: "Lesson 7: Core Data", duration: "29 mins", status: .locked)
            ]
        ),
        
        CourseModel(
            imageName: "course4",
            title: "Graphic Design Pro",
            lessons: 6,
            price: 19.99,
            isFavorite: false,
            description: "Master graphic design principles and create stunning visual content. Learn Adobe tools and design theory",
            duration: "15 hours",
            isPurchased: false,
            lessonsList: [
                Lesson(title: "Lesson 1: Design Principles", duration: "17 mins", status: .locked),
                Lesson(title: "Lesson 2: Color Theory", duration: "19 mins", status: .locked),
                Lesson(title: "Lesson 3: Typography", duration: "21 mins", status: .locked),
                Lesson(title: "Lesson 4: Layout Design", duration: "23 mins", status: .locked),
                Lesson(title: "Lesson 5: Branding", duration: "25 mins", status: .locked),
                Lesson(title: "Lesson 6: Portfolio", duration: "27 mins", status: .locked)
            ]
        ),
        
        CourseModel(
            imageName: "course5",
            title: "Video Editing Master",
            lessons: 8,
            price: 27.49,
            isFavorite: false,
            description: "Become a professional video editor. Learn advanced editing techniques and create cinematic content",
            duration: "22 hours",
            isPurchased: false,
            lessonsList: [
                Lesson(title: "Lesson 1: Editing Basics", duration: "17 mins", status: .locked),
                Lesson(title: "Lesson 2: Timeline & Clips", duration: "19 mins", status: .locked),
                Lesson(title: "Lesson 3: Transitions", duration: "21 mins", status: .locked),
                Lesson(title: "Lesson 4: Color Grading", duration: "23 mins", status: .locked),
                Lesson(title: "Lesson 5: Audio Mixing", duration: "25 mins", status: .locked),
                Lesson(title: "Lesson 6: Effects & Plugins", duration: "27 mins", status: .locked),
                Lesson(title: "Lesson 7: Export Settings", duration: "29 mins", status: .locked),
                Lesson(title: "Lesson 8: Final Project", duration: "31 mins", status: .locked)
            ]
        )
    ]
}
