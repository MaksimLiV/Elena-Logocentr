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
    
    // Name error label
    private lazy var nameErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.text = "Минимум 2 буквы, без цифр"
        label.isHidden = true
        label.numberOfLines = 0
        return label
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
    
    // Surname error label
    private lazy var surnameErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.text = "Минимум 2 буквы, без цифр"
        label.isHidden = true
        label.numberOfLines = 0
        return label
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
        configureSignInButton()
        setupActions()
        
        updateSignUpButtonState()
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(nameErrorLabel)
        contentView.addSubview(surnameLabel)
        contentView.addSubview(surnameTextField)
        contentView.addSubview(surnameErrorLabel)
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
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: - Name Label
            nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
            // MARK: - Name TextField
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // MARK: - Name Error Label
            nameErrorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 4),
            nameErrorLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: 4),
            nameErrorLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: -4),
            
            // MARK: - Surname Label
            surnameLabel.topAnchor.constraint(equalTo: nameErrorLabel.bottomAnchor, constant: 8),
            surnameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
            // MARK: - Surname TextField
            surnameTextField.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 8),
            surnameTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            surnameTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            surnameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // MARK: - Surname Error Label
            surnameErrorLabel.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 4),
            surnameErrorLabel.leadingAnchor.constraint(equalTo: surnameTextField.leadingAnchor, constant: 4),
            surnameErrorLabel.trailingAnchor.constraint(equalTo: surnameTextField.trailingAnchor, constant: -4),
            
            // MARK: - Email Label
            emailLabel.topAnchor.constraint(equalTo: surnameErrorLabel.bottomAnchor, constant: 8),
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
            passwordLabel.topAnchor.constraint(equalTo:  emailErrorLabel.bottomAnchor, constant: 8),
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
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 8),
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
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordErrorLabel.bottomAnchor, constant: 50),
            signUpButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            signUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
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
        
        nameLabel.attributedText = nameAttributedString
        
        // Configure Surname Label
        let surnameText = "Фамилия*"
        let surnameAttributedString = NSMutableAttributedString(string: surnameText)
        let surnameBlackRange = (surnameText as NSString).range(of: "Фамилия")
        surnameAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: surnameBlackRange)
        let surnameRedRange = (surnameText as NSString).range(of: "*")
        surnameAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: surnameRedRange)
        surnameLabel.attributedText = surnameAttributedString
        
        // Configure Email Label
        let emailText = "Электронная почта*"
        let emailAttributedString = NSMutableAttributedString(string: emailText)
        
        let emailBlackRange = (emailText as NSString).range(of: "Электронная почта")
        emailAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: emailBlackRange)
        
        let emailRedRange = (emailText as NSString).range(of: "*")
        emailAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: emailRedRange)
        
        emailLabel.attributedText = emailAttributedString
        
        // Configure Password Label
        let passwordText = "Пароль*"
        let passwordAttributedString = NSMutableAttributedString(string: passwordText)
        
        // "Пароль" - черный
        let passwordBlackRange = (passwordText as NSString).range(of: "Пароль")
        passwordAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: passwordBlackRange)
        
        // "*" - красный
        let passwordRedRange = (passwordText as NSString).range(of: "*")
        passwordAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: passwordRedRange)
        
        passwordLabel.attributedText = passwordAttributedString
        
        // Configure Confirm Password Label
        let confirmPasswordText = "Подтверждение пароля*"
        let confirmPasswordAttributedString = NSMutableAttributedString(string: confirmPasswordText)
        
        let confirmPasswordBlackRange = (confirmPasswordText as NSString).range(of: "Подтверждение пароля")
        confirmPasswordAttributedString.addAttribute(.foregroundColor, value: UIColor.label, range: confirmPasswordBlackRange)
        
        let confirmPasswordRedRange = (confirmPasswordText as NSString).range(of: "*")
        confirmPasswordAttributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: confirmPasswordRedRange)
        
        confirmPasswordLabel.attributedText = confirmPasswordAttributedString
    }
    
    // MARK: - Configure Sign In Button
    
    private func configureSignInButton() {
        let fullText = "Уже есть аккаунт? Войдите в аккаунт"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let grayRange = (fullText as NSString).range(of: "Уже есть аккаунт?")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: grayRange)
        
        let blueRange = (fullText as NSString).range(of: "Войдите в аккаунт")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: blueRange)
    }
    
    private func setupActions() {
        // TextField editing changed events
        nameTextField.addTarget(self, action: #selector(nameTextDidChange), for: .editingChanged)
        surnameTextField.addTarget(self, action: #selector(surnameTextDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(emailTextDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextDidChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextDidChange), for: .editingChanged)
    }
    
    // MARK: - Helper Methods
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateSignUpButtonState() {
        
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        let isFormValid = name.isValidName &&
        surname.isValidSurname &&
        email.isValidEmail &&
        password.isValidPassword &&
        password.matches(confirmPassword)
        
        signUpButton.isEnabled = isFormValid
        signUpButton.alpha = isFormValid ? 1.0 : 0.5
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    // MARK: - Actions
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        showPasswordButton.isSelected.toggle()
    }
    
    @objc private func toggleConfirmPasswordVisibility() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        showConfirmPasswordButton.isSelected.toggle()
    }
    
    // MARK: - TextField Handling
    
    // Name validation
    @objc private func nameTextDidChange() {
        guard let name = nameTextField.text, !name.isEmpty else {
            nameTextField.layer.borderColor = UIColor.systemGray4.cgColor
            nameTextField.layer.borderWidth = 1
            nameErrorLabel.isHidden = true
            updateSignUpButtonState()
            return
        }
        
        if name.isValidName {
            
            nameTextField.layer.borderColor = UIColor.systemGray4.cgColor
            nameTextField.layer.borderWidth = 1
            nameErrorLabel.isHidden = true
        } else {
            nameTextField.layer.borderColor = UIColor.systemRed.cgColor
            nameTextField.layer.borderWidth = 2
            nameErrorLabel.isHidden = false 
        }
        
        updateSignUpButtonState()
        
    }
    
    // Surname validation
    @objc private func surnameTextDidChange() {
        guard let surname = surnameTextField.text, !surname.isEmpty else {
            surnameTextField.layer.borderColor = UIColor.systemGray4.cgColor
            surnameTextField.layer.borderWidth = 1
            surnameErrorLabel.isHidden = true
            updateSignUpButtonState()
            return
        }
        
        if surname.isValidSurname {
            surnameTextField.layer.borderColor = UIColor.systemGray4.cgColor
            surnameTextField.layer.borderWidth = 1
            surnameErrorLabel.isHidden = true
        } else {
            surnameTextField.layer.borderColor = UIColor.systemRed.cgColor
            surnameTextField.layer.borderWidth = 2
            surnameErrorLabel.isHidden = false
        }
        
        updateSignUpButtonState()
    }
    
    // Email validation
    @objc private func emailTextDidChange() {
        guard let email = emailTextField.text, !email.isEmpty else {
            emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
            emailTextField.layer.borderWidth = 1
            emailErrorLabel.text = nil
            emailErrorLabel.isHidden = true
            updateSignUpButtonState()
            return
        }
        
        if email.isValidEmail {
            emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
            emailTextField.layer.borderWidth = 1
            emailErrorLabel.isHidden = true
            emailErrorLabel.text = nil
        } else {
            emailTextField.layer.borderColor = UIColor.systemRed.cgColor
            emailTextField.layer.borderWidth = 2
            emailErrorLabel.isHidden = false
            emailErrorLabel.text = "Неверный формат email Пример: name@example.com"
        }
        
        updateSignUpButtonState()
    }
    
    // Password validation
    @objc private func passwordTextDidChange() {
        guard let password = passwordTextField.text, !password.isEmpty else {
            passwordTextField.layer.borderColor = UIColor.systemGray4.cgColor
            passwordTextField.layer.borderWidth = 1
            passwordErrorLabel.isHidden = true
            updateSignUpButtonState()
            return
        }
        
        if password.isValidPassword {
            passwordTextField.layer.borderColor = UIColor.systemGray4.cgColor
            passwordTextField.layer.borderWidth = 1
            passwordErrorLabel.isHidden = true
        } else {
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            passwordTextField.layer.borderWidth = 2
            passwordErrorLabel.text = "Минимум 6 символов, 1 заглавная, 1 строчная, 1 цифра"
            passwordErrorLabel.isHidden = false
        }
        
        updateSignUpButtonState()
    }
    
    // Confirm Password validation
    @objc private func confirmPasswordTextDidChange() {
        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            confirmPasswordTextField.layer.borderColor = UIColor.systemGray4.cgColor
            confirmPasswordTextField.layer.borderWidth = 1
            confirmPasswordErrorLabel.isHidden = true
            updateSignUpButtonState()
            return
        }
        
        let password = passwordTextField.text ?? ""
        
        if password.matches(confirmPassword) {
            confirmPasswordTextField.layer.borderColor = UIColor.systemGray4.cgColor
            confirmPasswordTextField.layer.borderWidth = 1
            confirmPasswordErrorLabel.isHidden = true
        } else {
            confirmPasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
            confirmPasswordTextField.layer.borderWidth = 2
            confirmPasswordErrorLabel.text = "Пароли не совпадают"
            confirmPasswordErrorLabel.isHidden = false
        }
        
        updateSignUpButtonState()
    }
}
