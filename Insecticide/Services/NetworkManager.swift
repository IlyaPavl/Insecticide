//
//  NetworkManager.swift
//  Insecticide
//
//  Created by ily.pavlov on 14.01.2024.
//

import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let apiComponents = APIComponents.shared
    
    private func getData<T: Decodable>(from url: URL, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.noData))
                return
            }
            DispatchQueue.main.async {
                do {
                    let decodedData = try JSONDecoder().decode(modelType, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(APIError.decodingError))
                }
            }
        }.resume()
    }
    
    private func fetchData<T: Decodable>(for type: T.Type, from components: URLComponents, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = components.url else {
            completion(.failure(APIError.wrongURL))
            return
        }
        getData(from: url, modelType: type, completion: completion)
    }
    
    func fetchCards(offset: Int, limit: Int, completion: @escaping (Result<Cards, Error>) -> ()) {
        
        var components = apiComponents.cards
        components.queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        fetchData(for: Cards.self, from: components, completion: completion)
    }
    
    func searchCards(offset: Int, limit: Int, search: String, completion: @escaping (Result<Cards, Error>) -> ()) {
        
        var components = apiComponents.cards
        components.queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "search", value: "\(search)")
        ]
        
        fetchData(for: Cards.self, from: components, completion: completion)
    }
    
    func loadImage(from imageURL: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        var imageComponents = apiComponents.base
        imageComponents.path = imageURL
        
        if let imageUrl = imageComponents.url {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.noData))
                    return
                }
                
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(APIError.decodingError))
                }
            }.resume()
        } else {
            completion(.failure(APIError.wrongURL))
        }
    }
}

