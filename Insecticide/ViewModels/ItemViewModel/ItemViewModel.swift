//
//  ItemViewModel.swift
//  Insecticide
//
//  Created by ily.pavlov on 19.01.2024.
//

import UIKit

protocol ItemViewModelDelegate: AnyObject {
    func itemDataDidUpdate()
}

class ItemViewModel {
    
    private let networkManager = NetworkManager.shared
    weak var delegate: ItemViewModelDelegate?
    
    private(set) var itemModel: Card? {
        didSet {
            delegate?.itemDataDidUpdate()
        }
    }
    
    func fetchItemDataFor(id: Int) {
        networkManager.fetchItemFor(id: id) { [weak self] result in
            switch result {
            case .success(let success):
                self?.itemModel = success
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
