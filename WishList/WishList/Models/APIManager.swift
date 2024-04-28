//
//  APIManager.swift
//  WishList
//
//  Created by CaliaPark on 4/28/24.
//

import UIKit

struct APIManager {
    
    func fetchProducts(completion: @escaping ([Product]?) -> Void) {
        let urlString = "https://dummyjson.com/products"
        performRequest(with: urlString) { products in
            completion(products)
        }
    }
    
    func performRequest(with urlString: String, completion: @escaping ([Product]?) -> Void) {
       
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(nil)
                return
            }
            
            guard let safeData = data else {
                completion(nil)
                return
            }
            
            if let products = self.parseJSON(safeData) {
                completion(products)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ productData: Data) -> [Product]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Empty.self, from: productData)
        
            let productList = decodedData.products
            
            let myProductList = productList.map {
                Product(id: $0.id, title: $0.title, description: $0.description, price: $0.price, thumbnail: $0.thumbnail)
            }
            return myProductList
            
        } catch {
            print("Parsing failed")
            return nil
        }
    }
    
    func fetchImage(imageUrl: String, completion: @escaping ((UIImage)?) -> Void)  {
        
        if let imageUrl = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in

                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                }
            }.resume()
        }
    }
}
