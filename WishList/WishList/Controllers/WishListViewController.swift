//
//  WishListViewController.swift
//  WishList
//
//  Created by CaliaPark on 4/28/24.
//

import UIKit
import SnapKit

class WishListViewController: UIViewController {
    
    var wishList: [MyProduct] = []
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 0.9224274158, green: 0.9224274158, blue: 0.9224274158, alpha: 1)

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .left
        collectionView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        let point = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = MyProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", wishList[indexPath.row].id)

        do {
            let product = try context.fetch(request)
            if let productToDelete = product.first {
                context.delete(productToDelete)
            }
        } catch {
            print("Error while fetching or deleting object: \(error)")
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
        
        wishList.remove(at: indexPath.row)
        
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: [indexPath])
        }, completion: nil)
    }
}

// 컬렉션뷰 연습
extension WishListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MyCollectionViewCell else { fatalError("Failed to load cell") }
        let product = wishList[indexPath.row]
        cell.myProductLabel.text = "[\(product.id)] " + product.title! + " - \(product.price)$"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        return CGSize(width: availableWidth, height: 80)
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
