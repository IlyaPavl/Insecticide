//
//  WhereToBuyButton.swift
//  Insecticide
//
//  Created by ily.pavlov on 20.01.2024.
//

import UIKit

class WhereToBuyButton: UIButton {
    
    init(text: String, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setupButton(cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton(cornerRadius: CGFloat) {
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 1).cgColor
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.cornerRadius = cornerRadius
    }
    
}
