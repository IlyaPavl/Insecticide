//
//  InsecticideCollectionViewCell.swift
//  Insecticide
//
//  Created by ily.pavlov on 14.01.2024.
//

import UIKit

class InsecticideCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "InsecticideCollectionViewCell"

    private let imageView = UIImageView()
    private let remedyName = UILabel()
    private let remedyDescription = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        imageView.frame = CGRect(x: (self.frame.width - Constants.objectsWidth) / 2, y: Constants.sidePadding, width: Constants.objectsWidth, height: 82)
        
        let remedyNameSize = remedyName.sizeThatFits(CGSize(width: Constants.objectsWidth, height: CGFloat.greatestFiniteMagnitude))
        remedyName.frame = CGRect(x: (self.frame.width - Constants.objectsWidth) / 2, y: imageView.frame.maxY + Constants.littlePadding, width: remedyNameSize.width, height: remedyNameSize.height)
        


        let remedyDescriptionSize = remedyDescription.sizeThatFits(CGSize(width: Constants.objectsWidth, height: CGFloat.greatestFiniteMagnitude))
        remedyDescription.frame = CGRect(x: (self.frame.width - Constants.objectsWidth) / 2, y: remedyName.frame.maxY + Constants.littlePadding, width: remedyDescriptionSize.width, height: remedyDescriptionSize.height)
    }
    
    func setupCellWith(name: String, description: String) {

        self.remedyName.text = name
        self.remedyDescription.text = description
        remedyDescription.setLineSpacing(lineSpacing: 1.19)
        remedyDescription.lineBreakMode = .byTruncatingTail
    }
    
    func setupCellWith(image: UIImage) {

        self.imageView.image = image
    }

    private func setupCellViews() {

        self.layer.cornerRadius = Constants.commonCornerRadius
        self.backgroundColor = .white
        self.layer.shadowColor = Constants.shadowColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = Constants.commonCornerRadius
        
        //MARK: - setup imageView
        imageView.layer.cornerRadius = Constants.commonCornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        //MARK: - setup remedyName
        remedyName.font = UIFont(name: Constants.SemiboldFont, size: 13)
        remedyName.numberOfLines = 0
        remedyName.lineBreakMode = .byWordWrapping
        contentView.addSubview(remedyName)
        
        //MARK: - setup remedyDescription
        remedyDescription.font = UIFont(name: Constants.MediumFont, size: 12)
        remedyDescription.numberOfLines = 5
        remedyDescription.textColor = Constants.lightGreyTextColor
        contentView.addSubview(remedyDescription)
    }
}
