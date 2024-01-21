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
    
    private var searchText: String?
    
    private(set) var cardsModel: Cards = [] {
        didSet {
            delegate?.insecticideDataDidUpdate()
        }
    }
    
    private var limit = 20
    private var offset = 0
    private var isFetching = false
    private var hasMoreData = true
    
    func loadData(searchText: String? = nil) {
        guard !isFetching else { return }

        isFetching = true
        self.searchText = searchText
        offset = searchText == nil ? offset : 0

        networkManager.loadCards(offset: offset, limit: limit, search: searchText ?? "") { [weak self] result in
            defer {
                self?.isFetching = false
            }
            
            switch result {
            case .success(let success):
                if searchText == nil {
                    if success.isEmpty {
                        self?.hasMoreData = false
                    } else {
                        self?.cardsModel.append(contentsOf: success)
                        self?.offset += self?.limit ?? 0
                    }
                } else {
                    self?.cardsModel = success
                    self?.hasMoreData = !success.isEmpty
                    self?.offset += 20
                }
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
