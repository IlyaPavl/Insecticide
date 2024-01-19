//
//  InsecticideViewModel.swift
//  Insecticide
//
//  Created by ily.pavlov on 14.01.2024.
//

import UIKit

protocol InsecticideViewModelDelegate: AnyObject {
    func insecticideDataDidUpdate()
}

class InsecticideViewModel {
    
    private let networkManager = NetworkManager.shared
    weak var delegate: InsecticideViewModelDelegate?
    
    private(set) var cardsModel: Cards = [] {
        didSet {
            delegate?.insecticideDataDidUpdate()
        }
    }
    
    private var limit = 20
    private var offset = 0
    private var isFetching = false
    private var hasMoreData = true
    
    func fetchCardsData() {
        
        guard !isFetching, hasMoreData else { return }
        
        networkManager.fetchCards(offset: offset, limit: limit) { [weak self] result in
            defer {
                self?.isFetching = false
            }
            
            switch result {
            case .success(let success):
                if success.isEmpty {
                    self?.hasMoreData = false
                } else {
                    self?.cardsModel.append(contentsOf: success)
                    self?.offset += self?.limit ?? 0
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func searchCardsData(searchText: String) {
        networkManager.searchCards(offset: 0, limit: limit, search: searchText) { [weak self] result in
            switch result {
            case .success(let success):
                self?.cardsModel = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchImage(from imageURL: String, completion: @escaping (UIImage) -> ()) {
        
        networkManager.loadImage(from: imageURL) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let error):
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
            }
        }
    }
}
