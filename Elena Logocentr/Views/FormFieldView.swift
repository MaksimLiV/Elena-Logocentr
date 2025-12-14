//
//  FormFieldView.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 14/12/2025.
//

/*

import UIKit

class FormFieldView: UIView {
    
    // MARK: - UI Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.systemGray4.cgColor
        field.font = .systemFont(ofSize: 16)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        textField.placeholder = placeholder
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 40))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        setupUI()
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
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 4),
            errorLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -4),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


*/
