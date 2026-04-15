

> An iOS application for browsing and enrolling in online courses, built with Swift and UIKit.

---

## ✨ Features

-  **Home screen** — highlighted top picks and full course catalog
- **Course detail** — description, lessons list, and enrollment button
- **Favorites** — save and quickly access preferred courses
- **Authentication** — sign up, sign in, and forgot password flows
- **Tab bar navigation** — clean bottom navigation between main sections
-  **Reusable components** — custom cells and form fields across the app

---

## Project Structure

```
CoursesApp/
├── Application/           # AppDelegate & SceneDelegate
├── Cells/                 # Custom UICollectionView & UITableView cells
│   ├── AllCourseCell
│   ├── CourseDetailsCell
│   ├── EnrollButtonCell
│   ├── LessonCell
│   └── TopCourseCell
├── ViewControllers/       # All screens
│   ├── HomeViewController
│   ├── CoursesViewController
│   ├── CourseDetailViewController
│   ├── FavoriteViewController
│   ├── ProfileViewController
│   ├── SignInViewController
│   ├── SignUpViewController
│   ├── ForgotPasswordViewController
│   └── TabBarViewController
├── Views/                 # Reusable UI components
│   └── FormFieldView
├── Extensions/            # UIKit extensions
│   ├── UIButton
│   ├── scrollView
│   └── validator
├── CourseManager.swift    # Core data / business logic
└── SelfSizingCollectionView.swift
```

---

## 🏗 Architecture

The app follows the **MVC** pattern:

| Layer | Role |
|-------|------|
| `CourseManager` | Central data source — supplies course data to controllers |
| `ViewControllers` | Handle user interaction and screen logic |
| `Cells & Views` | Reusable UI components for clean, composable layouts |

---

## ⚙️ Requirements

| | |
|---|---|
| Platform | iOS 14+ |
| Language | Swift 5 |
| IDE | Xcode 13+ |
| Dependencies | None |

---

## 🚀 Getting Started

```bash
# 1. Clone the repo
git clone https://github.com/MaksimLiV/CoursesApp.git

# 2. Open in Xcode
open CoursesApp.xcodeproj

# 3. Select a simulator or device and run
# Cmd + R
```
