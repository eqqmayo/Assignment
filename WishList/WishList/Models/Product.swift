//
//  Product.swift
//  WishList
//
//  Created by CaliaPark on 4/28/24.
//

import Foundation

struct Empty: Codable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let thumbnail: String
}


