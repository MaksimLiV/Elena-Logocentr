//
//  Validator.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 29/11/2025.
//

import Foundation

extension String {

    // MARK: - Email Validation
    
    var isValidEmail: Bool {
        guard !isEmpty else { return false }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: self)
    }
    
    // MARK: - Password Validation
    var isValidPassword: Bool {
        guard !isEmpty else { return false }
        
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        
        return passwordPredicate.evaluate(with: self)
    }
    
    
}
