//
//  ItemViewController.swift
//  Insecticide
//
//  Created by ily.pavlov on 14.01.2024.
//

import UIKit


class ItemViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController()

        view.backgroundColor = .brown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)

        super.viewWillAppear(animated)
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func setupNavController() {
        print(#function)
        let backButtonImage = UIImage(systemName: "chevron.backward")
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
}
