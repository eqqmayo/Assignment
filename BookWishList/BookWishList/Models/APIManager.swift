//
//  APIManager.swift
//  BookWishList
//
//  Created by CaliaPark on 5/6/24.
//

import Foundation
import UIKit

class APIManager {
    
    func fetchBookData(with query: String, completion: @escaping ([Document]?) -> Void) {
        let urlString = "https://dapi.kakao.com/v3/search/book?target=title&query=\(query)"
        performRequest(with: urlString) { books in
            completion(books)
        }
    }
    
    func performRequest(with urlString: String, completion: @escaping ([Document]?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("KakaoAK b7e7daa3ed11126d4f02da107c884796", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let safeData = data else {
                print("Something is wrong with data")
                return
            }
            
            if let books = self.parseJSON(safeData) {
                completion(books)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ bookData: Data) -> [Document]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Empty.self, from: bookData)
            let bookList = decodedData.documents
            let myBookList = bookList.map {
                Document(authors: $0.authors, contents: $0.contents, salePrice: $0.salePrice, thumbnail: $0.thumbnail, title: $0.title)
            }
            return myBookList
            
        } catch {
            print("Parsing failed")
            return nil
        }
    }
    
    func fetchThumbnail(imageUrl: String, completion: @escaping ((UIImage)?) -> Void)  {
        if let imageUrl = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in

                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(UIImage(named: "Image"))
                }
            }.resume()
        }
    }
}
