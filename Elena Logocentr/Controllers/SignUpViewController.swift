//
//  SignUpViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 25/11/2025.
//

import UIKit

class signUpViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Properties
    
    // Scroll View & Content View
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    //Title label
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Регистрация"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Name label
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Имя*"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Name text field
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    //Surname label
    private lazy var surnameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Фамилия*"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Surname text field
    private lazy var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Фамилия"
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.backgroundColor = .systemBackground
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    // Email label
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Электронная почта*"
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
    
    // Email error label
    private lazy var emailErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.text = "Неверный формат email\nПример: name@example.com"
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
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    // Password label
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Пароль*"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        // Right view - show/hide password button
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        rightViewContainer.addSubview(showPasswordButton)
        showPasswordButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        textField.rightView = rightViewContainer
        textField.rightViewMode = .always
        
        return textField
    }()
    
    // Password error label
    private lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    // Show/Hide confirm password button
    private lazy var showConfirmPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.tintColor = .systemBlue
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(toggleConfirmPasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    // Confirm Password label
    private lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Подтвердите пароль*"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Confirm Password text field
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Подтвердите пароль"
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
        
        // Right view - show/hide button
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        rightViewContainer.addSubview(showConfirmPasswordButton)  // ← другая кнопка!
        showConfirmPasswordButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        textField.rightView = rightViewContainer
        textField.rightViewMode = .always
        
        return textField
    }()
    
    // Confirm Password error label
    private lazy var confirmPasswordErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    // Sign Up button
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Sign In button (link at the bottom)
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (scroll, content) = setupScrollableContent()
        self.scrollView = scroll
        self.contentView = content
        
        setupKeyboardHandling(for: scrollView)
        
        setupUI()
        setupConstraints()
        configureLabels()
        configureSignInButton()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Text field delegates
        nameTextField.delegate = self
        surnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        // Tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // Add all elements to content view
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(surnameLabel)
        contentView.addSubview(surnameTextField)
        contentView.addSubview(emailLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(emailErrorLabel)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(passwordErrorLabel)
        contentView.addSubview(confirmPasswordLabel)
        contentView.addSubview(confirmPasswordTextField)
        contentView.addSubview(confirmPasswordErrorLabel)
        contentView.addSubview(signUpButton)
        contentView.addSubview(signInButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: - Title Label
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // MARK: - Name Label
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
            // MARK: - Name TextField
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // MARK: - Surname Label
            surnameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            surnameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
            // MARK: - Surname TextField
            surnameTextField.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 8),
            surnameTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            surnameTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            surnameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // MARK: - Email Label
            emailLabel.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
            // MARK: - Email TextField
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // MARK: - Email Error Label
            emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4),
            emailErrorLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 4),
            emailErrorLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: -4),
            
            // MARK: - Password Label
            passwordLabel.topAnchor.constraint(equalTo:  emailTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
            // MARK: - Password TextField
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // MARK: - Password Error Label
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 4),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -4),
            
            // MARK: - Confirm Password Label
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 20),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
            // MARK: - Confirm Password TextField
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 8),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // MARK: - Confirm Password Error Label
            confirmPasswordErrorLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 4),
            confirmPasswordErrorLabel.leadingAnchor.constraint(equalTo: confirmPasswordTextField.leadingAnchor, constant: 4),
            confirmPasswordErrorLabel.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor, constant: -4),
            
            // MARK: - Sign Up Button
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordErrorLabel.bottomAnchor, constant: 30),
            signUpButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            
            // MARK: - Sign In Button
            signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
            signInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            // MARK: - Content View Bottom (ВАЖНО! Определяет высоту contentView)
            signInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
        ])
    }
    
    private func configureLabels() {
        
    }
    
    
    private func configureSignInButton() {
        
    }
    
    private func setupActions() {
        
        
    }
    
    // MARK: - Helper Methods
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    // MARK: - Actions
    
    @objc private func signUpButtonTapped() {
        // TODO: логика регистрации
    }
    
    @objc private func openSignInViewController() {
        let signInVC = signInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc private func togglePasswordVisibility() {
  
    }
    
    @objc private func toggleConfirmPasswordVisibility() {
    }
    
    
}

