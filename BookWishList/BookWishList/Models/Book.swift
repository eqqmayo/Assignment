//
//  Book.swift
//  BookWishList
//
//  Created by CaliaPark on 5/6/24.
//

import Foundation

struct Empty: Codable {
    let documents: [Document]
    let meta: Meta
}

struct Document: Codable {
    let authors: [String]
    let contents: String
    let salePrice: Int
    let thumbnail: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case authors, contents
        case salePrice = "sale_price"
        case thumbnail, title
    }
}

struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

