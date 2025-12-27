//
//  SignInViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 25/11/2025.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Properties
    
    // ScrollView components
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
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
    
    private lazy var emailErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.text = "Неверный формат, Пример: name@example.com"
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    // Show/Hide password button
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.tintColor = .systemBlue
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
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
        
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        rightViewContainer.addSubview(showPasswordButton)
        showPasswordButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        textField.rightView = rightViewContainer
        textField.rightViewMode = .always
        
        return textField
    }()
    
    // Main sign in button (blue)
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
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
        let button = UIButton(type: .custom)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup scrollable content using extension
        let (scroll, content) = setupScrollableContent()
        self.scrollView = scroll
        self.contentView = content
        
        // Setup keyboard handling
        setupKeyboardHandling(for: scrollView)
        
        setupUI()
        setupEmailValidation()
        setupConstraints()
        configureLabels()
        configureSignUpButton()
        setupActions()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // High keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        socialButtonsStackView.addArrangedSubview(facebookButton)
        socialButtonsStackView.addArrangedSubview(googleButton)
        
        // Add all elements to the screen
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(emailErrorLabel)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(signInButton)
        contentView.addSubview(forgotPasswordButton)
        contentView.addSubview(orContinueLabel)
        contentView.addSubview(socialButtonsStackView)
        contentView.addSubview(signUpButton)
        updateSignInButtonState()
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: Logo
            logoImageView.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 10),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 250),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Email Label
            emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Email Error Label
            emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 2),
            emailErrorLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 4),
            emailErrorLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: -4),
            
            // Password Label
            passwordLabel.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 5),
            passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Sign In Button
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signInButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 60),
            
            // Forgot Password
            forgotPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Or Continue Label
            orContinueLabel.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 25),
            orContinueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Social Buttons
            socialButtonsStackView.topAnchor.constraint(equalTo: orContinueLabel.bottomAnchor, constant: 25),
            socialButtonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            socialButtonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            socialButtonsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            // Sign Up Button (BOTTOM OF CONTENT)
            signUpButton.topAnchor.constraint(equalTo: socialButtonsStackView.bottomAnchor, constant: 30),
            signUpButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
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
    
    private func setupEmailValidation() {
        emailTextField.addTarget(self, action: #selector(emailTextDidChange), for: .editingChanged)
    }
    
    private func setupActions() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(openForgotPasswordViewController), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(openSignUpViewController), for: .touchUpInside)
        
        // Changes in text fields
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    // MARK: - Helper Methods
    private func showError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Called when the text in any of the text fields changes
    @objc private func textFieldDidChange() {
        updateSignInButtonState()
    }
    
    // Updates the state of the "Sign In" button depending on whether the fields are filled
    private func updateSignInButtonState() {
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        let isFormValid = emailText.isValidEmail && !passwordText.isEmpty
        signInButton.isEnabled = isFormValid
        signInButton.alpha = isFormValid ? 1.0 : 0.5
    }
    
    // MARK: - UITextFieldDelegate
    //Этот метод вызывается когда пользователь нажимает кнопку Return на клавиатуре.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            signInButtonTapped()
        }
        return true
    }
    
    
    // MARK: - Actions
    
    @objc private func signInButtonTapped() {
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        email.isValidEmail
        //  if else прописать значения
        
        password.isValidPassword
        
        
        let tabBarController = TabBarViewController()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
    }   // if else прописать з
    
    @objc private func emailTextDidChange() {
        guard let email = emailTextField.text, !email.isEmpty else {
            emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
            emailTextField.layer.borderWidth = 1
            emailErrorLabel.isHidden = true
            return
        }
        
        if email.isValidEmail {
            emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
            emailTextField.layer.borderWidth = 1
            emailErrorLabel.isHidden = true
        } else {
            emailTextField.layer.borderColor = UIColor.systemRed.cgColor
            emailTextField.layer.borderWidth = 2
            emailErrorLabel.isHidden = false
        }
    }
    
    // Toggle password visibility
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        showPasswordButton.isSelected.toggle()
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
