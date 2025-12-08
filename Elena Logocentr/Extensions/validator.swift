//
//  validator.swift
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
    
    // MARK: - Name Validation
    
    var isValidName: Bool {
        guard !isEmpty else { return false }
        
        guard count >= 2 else { return false }
        
        let nameRegex = "^[A-Za-zА-Яа-яЁё][A-Za-zА-Яа-яЁё\\s-]*$"
        let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        
        return namePredicate.evaluate(with: self)
    }
    
    // MARK: - Surname Validation
    
    var isValidSurname: Bool {
        // Фамилия использует ту же логику что и имя
        return isValidName
    }
    
    // MARK: - Password Validation
    
    var isValidPassword: Bool {
        guard !isEmpty else { return false }
        
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        
        return passwordPredicate.evaluate(with: self)
    }
    
    // MARK: - Password Match Validation
    
    func matches(_ other: String) -> Bool {
        return self == other && !self.isEmpty && !other.isEmpty
    }
    
}
