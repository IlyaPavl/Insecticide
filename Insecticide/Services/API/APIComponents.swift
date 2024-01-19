//
//  APIComponents.swift
//  Insecticide
//
//  Created by ily.pavlov on 14.01.2024.
//

import Foundation

struct APIComponents {

    static let shared = APIComponents()
    
    let base: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "shans.d2.i-partner.ru"
        return components
    }()

    let cards: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "shans.d2.i-partner.ru"
        components.path = "/api/ppp/index/"
        return components
    }()

    let item: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "shans.d2.i-partner.ru"
        components.path = "/api/ppp/item/"
        return components
    }()
}

