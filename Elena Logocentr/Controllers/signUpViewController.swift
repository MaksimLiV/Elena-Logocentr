//
//  SignUpViewController.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 25/11/2025.
//

import UIKit

class signUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Регистрация"
    }
    
    func openSignUpViewController() {
        let signUpVC = signUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

