//
//  UIButton.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 28/12/2025.
//

import UIKit

extension UIButton {
    
    static func createSymbolButton(
        symbolName: String,
        pointSize: CGFloat = 20,
        weight: UIImage.SymbolWeight = .regular,
        tintColor: UIColor = .label
    ) -> UIButton {
        let button = UIButton(type: .system)
        
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
        let image = UIImage(systemName: symbolName, withConfiguration: config)
        button.setImage(image, for: .normal)
        
        button.tintColor = tintColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    static func createFavoriteButton() -> UIButton {
        return createSymbolButton(
            symbolName: "heart",
            pointSize: 20,
            tintColor: .systemBlue
        )
    }
    
    func setFavorite(_ isFavorite: Bool, animated: Bool = false) {
        let iconName = isFavorite ? "heart.fill" : "heart"
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: iconName, withConfiguration: config)
        
        if animated {
            UIView.transition(
                with: self,
                duration: 0.2,
                options: .transitionCrossDissolve,
                animations: {
                    self.setImage(image, for: .normal)
                }
            )
        } else {
            setImage(image, for: .normal)
        }
    }
}
