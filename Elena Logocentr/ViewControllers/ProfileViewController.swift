//
//  ProfileViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 14/12/2025.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var userInfoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileIconView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var initialsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureUserData()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Профиль"
        
        view.addSubview(userInfoContainer)
        userInfoContainer.addSubview(profileIconView)
        profileIconView.addSubview(initialsLabel)
        userInfoContainer.addSubview(fullNameLabel)
        userInfoContainer.addSubview(emailLabel)
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userInfoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            userInfoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userInfoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userInfoContainer.heightAnchor.constraint(equalToConstant: 160),
            
            profileIconView.topAnchor.constraint(equalTo: userInfoContainer.topAnchor, constant: 20),
            profileIconView.centerXAnchor.constraint(equalTo: userInfoContainer.centerXAnchor),
            profileIconView.widthAnchor.constraint(equalToConstant: 80),
            profileIconView.heightAnchor.constraint(equalToConstant: 80),
            
            initialsLabel.centerXAnchor.constraint(equalTo: profileIconView.centerXAnchor),
            initialsLabel.centerYAnchor.constraint(equalTo: profileIconView.centerYAnchor),
            
            fullNameLabel.topAnchor.constraint(equalTo: profileIconView.bottomAnchor, constant: 12),
            fullNameLabel.centerXAnchor.constraint(equalTo: userInfoContainer.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4),
            emailLabel.centerXAnchor.constraint(equalTo: userInfoContainer.centerXAnchor),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    // MARK: - Configuration
    
    private func configureUserData() {
        guard let currentUser = UserSessionManager.shared.currentUser else { return }
        
        fullNameLabel.text = currentUser.name
        emailLabel.text = currentUser.email
        initialsLabel.text = currentUser.initials
    }
    
    // MARK: - Actions
    
    @objc private func logoutButtonTapped() {
        showLogoutConfirmation()
    }
    
    private func showLogoutConfirmation() {
        let alert = UIAlertController(
            title: "Выход",
            message: "Вы уверены, что хотите выйти?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        let logoutAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            self?.performLogout()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(logoutAction)
        
        present(alert, animated: true)
    }
    
    private func performLogout() {
        UserSessionManager.shared.logout()
        
        navigateToSignIn()
    }
    
    private func navigateToSignIn() {
        let signInVC = SignInViewController()
        let navController = UINavigationController(rootViewController: signInVC)
        navController.modalPresentationStyle = .fullScreen
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navController
            
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: nil
            )
        }
    }
}
