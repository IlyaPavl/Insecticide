//
//  InsecticideModel.swift
//  Insecticide
//
//  Created by ily.pavlov on 14.01.2024.
//

import Foundation

typealias Cards = [Card]

struct Card: Codable {
    let id: Int
    let image: String
    let categories: Categories
    let name, description: String
}

struct Categories: Codable {
    let id: Int
    let icon, image, name: String
}
