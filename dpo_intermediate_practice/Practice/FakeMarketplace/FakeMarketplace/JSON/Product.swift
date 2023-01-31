//
//  Product.swift
//  FakeMarketplace
//
//  Created by Николай Ногин on 29.10.2022.
//

import Foundation

struct Product: Codable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: String
    var rating: [String: Double]
}
