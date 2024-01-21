//
//  CustomButton.swift
//  Insecticide
//
//  Created by ily.pavlov on 20.01.2024.
//

import UIKit

class CustomButton: UIButton {
    
    private let pinIcon = UIImage(named: "pinIcon")
    
    init(text: String, cornerRadius: CGFloat) {
        
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setImageWithCustomSize(pinIcon, size: CGSize(width: 20, height: 20), for: .normal)
        setupButton(cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImageWithCustomSize(_ image: UIImage?, size: CGSize, for state: UIControl.State) {
        
        let resizedImage = image?.resize(targetSize: size)
        setImage(resizedImage, for: state)
    }
    
    func setupButton(cornerRadius: CGFloat) {
        
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 1).cgColor
        self.titleLabel?.font = UIFont(name: Constants.SemiboldFont, size: 12)
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.cornerRadius = cornerRadius
    }
}

extension UIImage {
    
    func resize(targetSize: CGSize) -> UIImage {
        
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}


