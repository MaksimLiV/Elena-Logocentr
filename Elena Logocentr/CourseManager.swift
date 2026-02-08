//  CourseManager.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 27/12/2025.
//

import Foundation

// MARK: - Course Model

struct CourseManager: Codable {
    let imageName: String
    let title: String
    let lessons: Int
    let price: Double
    var isFavorite: Bool
}

// MARK: - User Model
struct User: Codable {
    let name: String
    let email: String
    
    // Получение инициалов
    var initials: String {
        let components = name.components(separatedBy: " ")
        let initials = components.compactMap { $0.first }.prefix(2)
        return initials.map(String.init).joined().uppercased()
    }
    
    static let testEmail = "maksim@example.com"
    static let testPassword = "12345678"
    static let testName = "Максим Ли"
}

// MARK: - User Session Manager

class UserSessionManager {
    static let shared = UserSessionManager()
    
    private let defaults = UserDefaults.standard
    private let isLoggedInKey = "isLoggedIn"
    private let currentUserKey = "currentUser"
    
    private init() {}
    
    // MARK: - Current User
    var currentUser: User? {
        get {
            // Получаем Data из UserDefaults
            guard let data = defaults.data(forKey: currentUserKey) else {
                return nil
            }
            
            // Декодируем Data в User модель
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                return user
            } catch {
                print("❌ Ошибка декодирования пользователя: \(error)")
                return nil
            }
        }
        
        set {
            if let user = newValue {
                // Кодируем User модель в Data
                do {
                    let data = try JSONEncoder().encode(user)
                    defaults.set(data, forKey: currentUserKey)
                } catch {
                    print("❌ Ошибка кодирования пользователя: \(error)")
                }
            } else {
                // Если nil, удаляем данные
                defaults.removeObject(forKey: currentUserKey)
            }
        }
    }
    
    var isLoggedIn: Bool {
        return defaults.bool(forKey: isLoggedInKey)
    }
    
    // ✅ Метод для входа через форму
    func login(email: String, password: String) -> Bool {
        if email == User.testEmail && password == User.testPassword {
            let user = User(
                name: User.testName,
                email: User.testEmail
            )
            self.currentUser = user
            
            // ✅ Сохраняем только флаг isLoggedIn в UserDefaults
            defaults.set(true, forKey: isLoggedInKey)
            
            print("✅ Успешный вход: \(user.name)")
            return true
        }
        print("❌ Неверный email или пароль")
        return false
    }
    
    func logout() {
        currentUser = nil
        
        // ✅ Обнуляем только флаг isLoggedIn в UserDefaults
        defaults.set(false, forKey: isLoggedInKey)
        
        print("🚪 Выход выполнен")
    }
}

// MARK: - Course Computed Properties

extension CourseManager {
    
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

// MARK: - Course Management

extension CourseManager {
    
    private static let coursesKey = "savedCourses"
    
    private static var _shared: [CourseManager]?
    
    static var shared: [CourseManager] {
        get {
            guard let shared = _shared else {
                let courses = loadCourses()
                _shared = courses
                return courses
            }
            return shared
        }
        set {
            _shared = newValue
        }
    }
    
    static var favorites: [CourseManager] {
        return shared.filter { $0.isFavorite }
    }
    
    static func toggleFavorite(at index: Int) {
        guard index >= 0 && index < shared.count else { return }
        shared[index].isFavorite.toggle()
        
        print(shared[index].isFavorite
              ? "✅ '\(shared[index].title)' добавлен в избранное"
              : "❌ '\(shared[index].title)' удалён из избранного")
        
        saveCourses()
    }
    
    static func findIndex(byTitle title: String) -> Int? {
        return shared.firstIndex { $0.title == title }
    }
    
    // Сохраняет текущий список курсов в UserDefaults
    
    static func saveCourses() {
        do {
            let data = try JSONEncoder().encode(shared)
            UserDefaults.standard.set(data, forKey: coursesKey)
            print ("Курсы сохранены")
        } catch {
            print("Не удалось сохранить курсы: \(error)")
        }
    }
    
    // Загружает курсы из UserDefaults или возвращает начальные данные
    private static func loadCourses() -> [CourseManager] {
        if let data = UserDefaults.standard.data(forKey: coursesKey) {
            do {
                let courses = try JSONDecoder().decode([CourseManager].self, from: data)
                print("Курсы загружены из UserDefaults (\(courses.count) шт.)")
                return courses
            } catch {
                print ("Курсы не загружены \(error)")
            }
        }
        
        print("Загружены начальные курсы")
        return sampleData
    }
    
    private static let sampleData: [CourseManager] = [
        CourseManager(
            imageName: "course1",
            title: "3D Design Basic",
            lessons: 24,
            price: 24.99,
            isFavorite: false
        ),
        CourseManager(
            imageName: "course2",
            title: "Characters Animation",
            lessons: 22,
            price: 22.69,
            isFavorite: false
        ),
        CourseManager(
            imageName: "course3",
            title: "iOS Development",
            lessons: 30,
            price: 29.99,
            isFavorite: false
        ),
        CourseManager(
            imageName: "course4",
            title: "Graphic Design Pro",
            lessons: 18,
            price: 19.99,
            isFavorite: false
        ),
        CourseManager(
            imageName: "course5",
            title: "Video Editing Master",
            lessons: 25,
            price: 27.49,
            isFavorite: false
        )
    ]
}
