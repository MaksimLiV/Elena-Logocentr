//
//  SignUpViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 25/11/2025.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Properties
    
    // Scroll View & Content View
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    // Custom TextFields
    private lazy var nameField = CustomTextField(
        title: "Имя*",
        placeholder: "Имя",
        errorText: "Минимум 2 буквы, без цифр",
        autocapitalizationType: .words
    )
    
    private lazy var surnameField = CustomTextField(
        title: "Фамилия*",
        placeholder: "Фамилия",
        errorText: "Минимум 2 буквы, без цифр",
        autocapitalizationType: .words
    )
    
    private lazy var emailField = CustomTextField(
        title: "Электронная почта*",
        placeholder: "Электронная почта",
        errorText: "Неверный формат, Пример: name@example.com",
        keyboardType: .emailAddress
    )
    
    private lazy var passwordField = CustomTextField(
        title: "Пароль*",
        placeholder: "Пароль",
        errorText: "Минимум 6 символов, заглавная буква и цифра",
        isSecure: true
    )
    
    private lazy var confirmPasswordField = CustomTextField(
        title: "Подтвердите пароль*",
        placeholder: "Подтвердите пароль",
        errorText: "Пароли не совпадают",
        isSecure: true
    )
    
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
    
    // Show/Hide confirm password button
    private lazy var showConfirmPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.tintColor = .systemBlue
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(toggleConfirmPasswordVisibility), for: .touchUpInside)
        return button
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
    
    // Sign In button (navigation to Sign In)
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (scroll, content) = setupScrollableContent()
        self.scrollView = scroll
        self.contentView = content
        
        title = "Регистрация"
        setupKeyboardHandling(for: scrollView)
        
        setupUI()
        setupConstraints()
        configureLabels()
        setupActions()
        updateSignUpButtonState()
        
        // Dismiss keyboard on tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        contentView.addSubview(nameField)
        contentView.addSubview(surnameField)
        contentView.addSubview(emailField)
        contentView.addSubview(passwordField)
        contentView.addSubview(confirmPasswordField)
        contentView.addSubview(signUpButton)
        contentView.addSubview(signInButton)
        
        // Add show password buttons to right view
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        rightViewContainer.addSubview(showPasswordButton)
        showPasswordButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        passwordField.textField.rightView = rightViewContainer
        passwordField.textField.rightViewMode = .always
        
        let confirmRightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        confirmRightViewContainer.addSubview(showConfirmPasswordButton)
        showConfirmPasswordButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        confirmPasswordField.textField.rightView = confirmRightViewContainer
        confirmPasswordField.textField.rightViewMode = .always
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // MARK: - Name Field
            nameField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // MARK: - Surname Field
            surnameField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 8),
            surnameField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            surnameField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            // MARK: - Email Field
            emailField.topAnchor.constraint(equalTo: surnameField.bottomAnchor, constant: 8),
            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            // MARK: - Password Field
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 8),
            passwordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            // MARK: - Confirm Password Field
            confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 8),
            confirmPasswordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            confirmPasswordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            // MARK: - Sign Up Button
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 50),
            signUpButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            
            // MARK: - Sign In Button
            signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 16),
            signInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
        ])
    }
    
    private func configureLabels() {
        
        // Configure Name label
        let nameText = "Имя*"
        let nameAttributedString = NSMutableAttributedString(string: nameText)
        
        let nameBlackRange = (nameText as NSString).range(of: "Имя")
        nameAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: nameBlackRange)
        
        let nameRedRange = (nameText as NSString).range(of: "*")
        nameAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: nameRedRange)
        
        // Apply to the internal titleLabel through a helper method
        configureTitleLabel(for: nameField, with: nameAttributedString)
        
        // Configure Surname Label
        let surnameText = "Фамилия*"
        let surnameAttributedString = NSMutableAttributedString(string: surnameText)
        let surnameBlackRange = (surnameText as NSString).range(of: "Фамилия")
        surnameAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: surnameBlackRange)
        let surnameRedRange = (surnameText as NSString).range(of: "*")
        surnameAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: surnameRedRange)
        
        configureTitleLabel(for: surnameField, with: surnameAttributedString)
        
        // Configure Email Label
        let emailText = "Электронная почта*"
        let emailAttributedString = NSMutableAttributedString(string: emailText)
        
        let emailBlackRange = (emailText as NSString).range(of: "Электронная почта")
        emailAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: emailBlackRange)
        
        let emailRedRange = (emailText as NSString).range(of: "*")
        emailAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: emailRedRange)
        
        configureTitleLabel(for: emailField, with: emailAttributedString)
        
        // Configure Password Label
        let passwordText = "Пароль*"
        let passwordAttributedString = NSMutableAttributedString(string: passwordText)
        
        let passwordBlackRange = (passwordText as NSString).range(of: "Пароль")
        passwordAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: passwordBlackRange)
        
        let passwordRedRange = (passwordText as NSString).range(of: "*")
        passwordAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: passwordRedRange)
        
        configureTitleLabel(for: passwordField, with: passwordAttributedString)
        
        // Configure Confirm Password Label
        let confirmPasswordText = "Подтвердите пароль*"
        let confirmPasswordAttributedString = NSMutableAttributedString(string: confirmPasswordText)
        
        let confirmPasswordBlackRange = (confirmPasswordText as NSString).range(of: "Подтвердите пароль")
        confirmPasswordAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: confirmPasswordBlackRange)
        
        let confirmPasswordRedRange = (confirmPasswordText as NSString).range(of: "*")
        confirmPasswordAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: confirmPasswordRedRange)
        
        configureTitleLabel(for: confirmPasswordField, with: confirmPasswordAttributedString)
    }
    
    
    // Helper method to access titleLabel from CustomTextField
    private func configureTitleLabel(for customField: CustomTextField, with attributedText: NSAttributedString) {
        // Access the first subview which is titleLabel
        if let titleLabel = customField.subviews.first(where: { $0 is UILabel }) as? UILabel {
            titleLabel.attributedText = attributedText
        }
    }
    
    // MARK: - Setup Actions
    
    private func setupActions() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(openSignInViewController), for: .touchUpInside)
        
        nameField.textField.addTarget(self, action: #selector(nameTextDidChange), for: .editingChanged)
        surnameField.textField.addTarget(self, action: #selector(surnameTextDidChange), for: .editingChanged)
        emailField.textField.addTarget(self, action: #selector(emailTextDidChange), for: .editingChanged)
        passwordField.textField.addTarget(self, action: #selector(passwordTextDidChange), for: .editingChanged)
        confirmPasswordField.textField.addTarget(self, action: #selector(confirmPasswordTextDidChange), for: .editingChanged)
        
        // Set delegates
        nameField.textField.delegate = self
        surnameField.textField.delegate = self
        emailField.textField.delegate = self
        passwordField.textField.delegate = self
        confirmPasswordField.textField.delegate = self
    }
    
    // MARK: - Helper Methods
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateSignUpButtonState() {
        let name = nameField.getText()
        let surname = surnameField.getText()
        let email = emailField.getText()
        let password = passwordField.getText()
        let confirmPassword = confirmPasswordField.getText()
        
        let isFormValid = name.isValidName &&
        surname.isValidSurname &&
        email.isValidEmail &&
        password.isValidPassword &&
        password.matches(confirmPassword)
        
        signUpButton.isEnabled = isFormValid
        signUpButton.alpha = isFormValid ? 1.0 : 0.5
    }
    
    // MARK: - Actions
    
    @objc private func signUpButtonTapped() {
        
        // TODO: API запрос для регистрации
        
    }
    
    @objc private func togglePasswordVisibility() {
        passwordField.textField.isSecureTextEntry.toggle()
        showPasswordButton.isSelected.toggle()
    }
    
    @objc private func toggleConfirmPasswordVisibility() {
        confirmPasswordField.textField.isSecureTextEntry.toggle()
        showConfirmPasswordButton.isSelected.toggle()
    }
    
    @objc private func openSignInViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - TextField Handling
    
    @objc private func nameTextDidChange() {
        let name = nameField.getText()
        
        guard !name.isEmpty else {
            nameField.hideError()
            updateSignUpButtonState()
            return
        }
        
        if name.isValidName {
            nameField.hideError()
        } else {
            nameField.showError()
        }
        
        updateSignUpButtonState()
    }
    
    @objc private func surnameTextDidChange() {
        let surname = surnameField.getText()
        
        guard !surname.isEmpty else {
            surnameField.hideError()
            updateSignUpButtonState()
            return
        }
        
        if surname.isValidSurname {
            surnameField.hideError()
        } else {
            surnameField.showError()
        }
        
        updateSignUpButtonState()
    }
    
    @objc private func emailTextDidChange() {
        let email = emailField.getText()
        
        guard !email.isEmpty else {
            emailField.hideError()
            updateSignUpButtonState()
            return
        }
        
        if email.isValidEmail {
            emailField.hideError()
        } else {
            emailField.showError()
        }
        
        updateSignUpButtonState()
    }
    
    @objc private func passwordTextDidChange() {
        let password = passwordField.getText()
        let confirmPassword = confirmPasswordField.getText()
        
        guard !password.isEmpty else {
            passwordField.hideError()
            updateSignUpButtonState()
            return
        }
        
        if password.isValidPassword {
            passwordField.hideError()
        } else {
            passwordField.showError()
        }
        
        if !confirmPassword.isEmpty {
            if password.matches(confirmPassword) {
                confirmPasswordField.hideError()
            } else {
                confirmPasswordField.showError()
            }
        }
        
        updateSignUpButtonState()
    }
    
    @objc private func confirmPasswordTextDidChange() {
        let password = passwordField.getText()
        let confirmPassword = confirmPasswordField.getText()
        
        guard !confirmPassword.isEmpty else {
            confirmPasswordField.hideError()
            updateSignUpButtonState()
            return
        }
        
        if password.matches(confirmPassword) {
            confirmPasswordField.hideError()
        } else {
            confirmPasswordField.showError()
        }
        
        updateSignUpButtonState()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField.textField:
            surnameField.textField.becomeFirstResponder()
        case surnameField.textField:
            emailField.textField.becomeFirstResponder()
        case emailField.textField:
            passwordField.textField.becomeFirstResponder()
        case passwordField.textField:
            confirmPasswordField.textField.becomeFirstResponder()
        case confirmPasswordField.textField:
            confirmPasswordField.textField.resignFirstResponder()
            if signUpButton.isEnabled {
                signUpButtonTapped()
            }
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
