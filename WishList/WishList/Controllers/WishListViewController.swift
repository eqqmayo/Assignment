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
    }
}

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
