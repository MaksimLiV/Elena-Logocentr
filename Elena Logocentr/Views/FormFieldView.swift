//
//  CustomTextField.swift
//  Elena Logocentr
//
//  Created by Maksim Li
//

import UIKit

class CustomTextField: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.backgroundColor = .systemBackground
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Height constraint для динамического изменения
    private var errorLabelHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Initialization
    
    init(title: String, placeholder: String, errorText: String, keyboardType: UIKeyboardType = .default, isSecure: Bool = false, autocapitalizationType: UITextAutocapitalizationType = .none) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        textField.placeholder = placeholder
        errorLabel.text = errorText
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecure
        textField.autocapitalizationType = autocapitalizationType
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(errorLabel)
    }
    
    private func setupConstraints() {
       
        errorLabelHeightConstraint = errorLabel.heightAnchor.constraint(equalToConstant: 0)
        errorLabelHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // Text Field
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            // Error Label
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    
    func showError() {
        textField.layer.borderColor = UIColor.systemRed.cgColor
        textField.layer.borderWidth = 2
        errorLabel.isHidden = false
        
   
        UIView.animate(withDuration: 0.3) {

            self.errorLabelHeightConstraint.isActive = false
            self.layoutIfNeeded()
        }
    }
    
    func hideError() {
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.borderWidth = 1
        
        UIView.animate(withDuration: 0.3, animations: {
            self.errorLabelHeightConstraint.isActive = true
            self.layoutIfNeeded()
        }) { _ in
            self.errorLabel.isHidden = true
        }
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
    
    func setText(_ text: String) {
        textField.text = text
    }
}
