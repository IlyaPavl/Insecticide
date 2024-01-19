//
//  InsecticideViewController.swift
//  Insecticide
//
//  Created by ily.pavlov on 14.01.2024.
//

import UIKit

final class InsecticideViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let searchBar = UISearchBar()
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: Constants.sideInsets, left: Constants.sideInsets, bottom: Constants.sideInsets, right: Constants.sideInsets)
    
    private var viewModel = InsecticideViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSearchBar()
        hideKeyboardOnTap()
        setupCollectionUI()
        
        viewModel.fetchCardsData()
        viewModel.delegate = self
    }
    
    private func setupNavBar() {
        
        self.navigationItem.title = "Список"
        navigationItem.backButtonDisplayMode = .minimal
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc private func searchButtonTapped() {
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
        self.navigationItem.rightBarButtonItem = .none
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Поиск"
    }
}

//MARK: - InsecticideViewModelDelegate
extension InsecticideViewController: InsecticideViewModelDelegate {
    func insecticideDataDidUpdate() {
        // Perform the reload with animation
        UIView.transition(with: collectionView, duration: 0.1, options: .transitionCrossDissolve, animations: { self.collectionView.reloadData() })
    }
}


//MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension InsecticideViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.cardsModel.count)
        
        return viewModel.cardsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InsecticideCollectionViewCell.reuseIdentifier, for: indexPath) as? InsecticideCollectionViewCell else {
            fatalError("Unable to dequeue InsecticideCollectionViewCell")
        }
        let card = viewModel.cardsModel[indexPath.item]
        cell.setupCellWith(name: card.name, description: card.description)
        viewModel.fetchImage(from: card.categories.image) { image in
            cell.setupCellWith(image: image)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: Constants.collectionHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let itemVC = ItemViewController()
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    
}

//MARK: - UICollectionViewDelegate
extension InsecticideViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let lastIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.item == lastIndex {
            viewModel.fetchCardsData()
        }
    }
}

//MARK: - setup UI
extension InsecticideViewController {
    private func setupCollectionUI() {
        
        self.view.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height - 100), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.register(InsecticideCollectionViewCell.self, forCellWithReuseIdentifier: InsecticideCollectionViewCell.reuseIdentifier)
    }
}

extension InsecticideViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonTapped()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCardsData(searchText: searchText)
    }
}

// MARK: - keyboard setup
extension InsecticideViewController{
    func hideKeyboardOnTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
        if searchBar.searchTextField.text == "" {
            navigationItem.titleView = nil
            setupNavBar()
        }
    }
}
