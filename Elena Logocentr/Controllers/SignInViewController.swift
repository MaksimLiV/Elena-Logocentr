//
//  SignInViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 25/11/2025.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - UI Properties
    
    // Logo
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage (named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //Title label
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Войдите в свой аккаунт"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Email label
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Password label (above password field)
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Email text field
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Электронная почта"
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.backgroundColor = .systemBackground
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    // Password text field
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.borderStyle = .none
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.backgroundColor = .systemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    // Main sign in button (blue)
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // "or continue with" label
    private lazy var orContinueLabel: UILabel = {
        let label = UILabel()
        label.text = "or continue with"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Facebook button
    private lazy var facebookButton: UIButton = {
        var config = UIButton.Configuration.plain()
        
        // Title
        config.title = "Facebook"
        config.baseForegroundColor = .label
        
        // Icon
        if let originalIcon = UIImage(named: "facebook-icon") {
            let targetSize = CGSize(width: 20, height: 20)
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            let resizedIcon = renderer.image { _ in
                originalIcon.draw(in: CGRect(origin: .zero, size: targetSize))
            }
            config.image = resizedIcon.withRenderingMode(.alwaysOriginal)
        }
        
        // Spacing between icon and text
        config.imagePadding = 8
        config.imagePlacement = .leading  // icon слева от текста
        
        // Create button with configuration
        let button = UIButton(configuration: config)
        
        // Style
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Google button
    private lazy var googleButton: UIButton = {
        var config = UIButton.Configuration.plain()
        
        // Title
        config.title = "Google"
        config.baseForegroundColor = .label
        
        // Icon
        if let originalIcon = UIImage(named: "google-icon") {
            let targetSize = CGSize(width: 20, height: 20)
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            let resizedIcon = renderer.image { _ in
                originalIcon.draw(in: CGRect(origin: .zero, size: targetSize))
            }
            config.image = resizedIcon.withRenderingMode(.alwaysOriginal)
        }
        
        // Spacing between icon and text
        config.imagePadding = 8
        config.imagePlacement = .leading  // icon слева от текста
        
        // Create button with configuration
        let button = UIButton(configuration: config)
        
        // Style
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // StackView for social buttons (container)
    private lazy var socialButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Sign up button (at the bottom)
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureLabels()
        configureSignUpButton()
        setupActions()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        
        socialButtonsStackView.addArrangedSubview(facebookButton)
        socialButtonsStackView.addArrangedSubview(googleButton)
        
        // Add all elements to the screen
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(orContinueLabel)
        view.addSubview(socialButtonsStackView)
        view.addSubview(signUpButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            //Logo
            logoImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 250),
            
            // Title label
            titleLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            // Email label
            emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -8),
            emailLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 16),
            
            // Email TextField
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Password Label
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -8),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 16),
            
            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Sign In Button
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            signInButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            //Forgot password
            forgotPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Or Continue Label
            orContinueLabel.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 25),
            orContinueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Social Buttons StackView
            socialButtonsStackView.topAnchor.constraint(equalTo: orContinueLabel.bottomAnchor, constant: 25),
            socialButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            socialButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            socialButtonsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            // Sign Up Button
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Configure Labels
    
    private func configureLabels() {
        // Configure Email Label
        let emailText = "Электронная почта*"
        let emailAttributedString = NSMutableAttributedString(string: emailText)
        
        // "Электронная почта"
        let emailBlackRange = (emailText as NSString).range(of: "Электронная почта")
        emailAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: emailBlackRange)
        
        // "*" - red
        let emailRedRange = (emailText as NSString).range(of: "*")
        emailAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: emailRedRange)
        
        emailLabel.attributedText = emailAttributedString
        
        // Configure Password Label
        let passwordText = "Пароль*"
        let passwordAttributedString = NSMutableAttributedString(string: passwordText)
        
        // "Пароль"
        let passwordBlackRange = (passwordText as NSString).range(of: "Пароль")
        passwordAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: passwordBlackRange)
        
        // "*" - red
        let passwordRedRange = (passwordText as NSString).range(of: "*")
        passwordAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: passwordRedRange)
        
        passwordLabel.attributedText = passwordAttributedString
    }
    
    // MARK: - Configure Sign Up Button
    
    private func configureSignUpButton() {
        let fullText = "Все еще нет аккаунта? Зарегистрируйтесь"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // First part - gray
        let grayRange = (fullText as NSString).range(of: "Все еще нет аккаунта?")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: grayRange)
        
        // Second part - blue
        let blueRange = (fullText as NSString).range(of: "Зарегистрируйтесь")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: blueRange)
        
        signUpButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    // MARK: - Setup Actions
    
    private func setupActions() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(openForgotPasswordViewController), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(openSignUpViewController), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func signInButtonTapped() {
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
    }
    
    @objc private func openSignUpViewController() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func openForgotPasswordViewController() {
        let forgotPasswordVC = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
}
