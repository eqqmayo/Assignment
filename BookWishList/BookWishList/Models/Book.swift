//
//  Book.swift
//  BookWishList
//
//  Created by CaliaPark on 5/6/24.
//

import Foundation

struct FetchedBook {
    let documents: [Document]
    let isEnd: Bool
}

struct Empty: Codable {
    let documents: [Document]
    let meta: Meta
}

struct Document: Codable, Equatable {
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
    
    static func ==(lhs: Document, rhs: Document) -> Bool {
        return lhs.authors == rhs.authors &&
                lhs.contents == rhs.contents &&
                lhs.salePrice == rhs.salePrice &&
                lhs.thumbnail == rhs.thumbnail &&
                lhs.title == rhs.title
    }
}

struct Meta: Codable {
    let isEnd: Bool
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
    }
}

