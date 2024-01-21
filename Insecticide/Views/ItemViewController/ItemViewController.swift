//
//  ItemViewController.swift
//  Insecticide
//
//  Created by ily.pavlov on 14.01.2024.
//

import UIKit


class ItemViewController: UIViewController {
    
    private var itemID: Int?
    private let viewModel = ItemViewModel()
    
    private let imageView = UIImageView()
    private let remedyName = UILabel()
    private let remedyDescription = UILabel()
    private let typeIcon = UIImageView()
    private let favIcon = UIImageView()
    private let buyButton = CustomButton(text: "ГДЕ КУПИТЬ", cornerRadius: Constants.commonCornerRadius)
    
    convenience init(itemID: Int) {
        self.init()
        self.itemID = itemID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController()
        setupItemUI()
        
        viewModel.delegate = self
        if let itemID = itemID {
            viewModel.fetchItemDataFor(id: itemID)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupItemLayout()
    }
    
    private func setupCellWith(name: String, description: String) {
        self.remedyName.text = name
        self.remedyDescription.text = description
        remedyName.setLineSpacing(lineSpacing: 1.17)
        remedyDescription.setLineSpacing(lineSpacing: 1.23)
    }
    
    private func setupItemWith(image: UIImage) {
        self.imageView.image = image
    }
    
    private func setupItemWith(icon: UIImage) {
        self.typeIcon.image = icon
    }
}

extension ItemViewController: ItemViewModelDelegate {
    func itemDataDidUpdate() {
        guard let itemModel = viewModel.itemModel else { return }
        setupCellWith(name: itemModel.name, description: itemModel.description)
        
        viewModel.fetchImage(from: itemModel.image) { [weak self] image in
            self?.setupItemWith(image: image)
        }
        
        viewModel.fetchImage(from: itemModel.categories.icon) { [weak self] icon in
            self?.setupItemWith(icon: icon)
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

extension ItemViewController {
    private func setupItemUI() {
        view.backgroundColor = .white
        
        //MARK: - setup imageView
        imageView.layer.cornerRadius = Constants.commonCornerRadius
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        //MARK: - setup remedyName
        remedyName.font = UIFont(name: Constants.SemiboldFont, size: 20)
        remedyName.numberOfLines = 0
        remedyName.lineBreakMode = .byWordWrapping
        view.addSubview(remedyName)
        
        //MARK: - setup remedyDescription
        remedyDescription.font = UIFont(name: Constants.RegularFont, size: 15)
        remedyDescription.numberOfLines = 0
        remedyDescription.textColor = Constants.lightGreyTextColor
        view.addSubview(remedyDescription)
        
        //MARK: - setup typeIcon
        typeIcon.contentMode = .scaleAspectFit
        typeIcon.clipsToBounds = true
        view.addSubview(typeIcon)

        //MARK: - setup favIcon
        favIcon.tintColor = .systemGray3
        favIcon.image = UIImage(systemName: "star")
        favIcon.contentMode = .scaleAspectFit
        favIcon.clipsToBounds = true
        view.addSubview(favIcon)
        
        view.addSubview(buyButton)
    }
    
    private func setupItemLayout() {
        let navBarHeight = UIApplication.shared.statusBarFrame.size.height + (navigationController?.navigationBar.frame.height ?? 0.0)
        
        imageView.frame = CGRect(x: Constants.sidePaddinPlus, y: navBarHeight + (Constants.sidePadding * 2), width: view.frame.width - Constants.sidePaddinPlus * 2, height: 215)
        
        let remedyNameSize = remedyName.sizeThatFits(CGSize(width: view.frame.width - Constants.sidePaddinPlus * 2, height: CGFloat.greatestFiniteMagnitude))
        remedyName.frame = CGRect(x: Constants.sidePaddinPlus, y: imageView.frame.maxY + Constants.sidePaddinPlus * 2, width: remedyNameSize.width, height: remedyNameSize.height)
        
        let remedyDescriptionSize = remedyDescription.sizeThatFits(CGSize(width: view.frame.width - Constants.sidePaddinPlus * 2, height: CGFloat.greatestFiniteMagnitude))
        remedyDescription.frame = CGRect(x: Constants.sidePaddinPlus, y: remedyName.frame.maxY + Constants.littlePadding, width: remedyDescriptionSize.width, height: remedyDescriptionSize.height)
        
        let typeIconSize: CGFloat = 32
        typeIcon.frame = CGRect(x: imageView.frame.minX + Constants.sidePaddinPlus, y: imageView.frame.minY + Constants.sidePaddingPlusPlus, width: typeIconSize, height: typeIconSize)
        
        let favIconSize: CGFloat = 32
        favIcon.frame = CGRect(x: imageView.frame.maxX - (Constants.sidePaddingPlusPlus) - favIconSize, y: imageView.frame.minY + Constants.sidePaddingPlusPlus, width: favIconSize, height: favIconSize)
        
        let buyButtonHeight: CGFloat = 36
        buyButton.frame = CGRect(x: Constants.sidePaddinPlus, y: remedyDescription.frame.maxY + Constants.sidePaddingPlusPlus, width: view.frame.width - Constants.sidePaddinPlus * 2, height: buyButtonHeight)
    }
    
    private func setupNavController() {
        
        navigationController?.navigationBar.tintColor = .white
    }
}
