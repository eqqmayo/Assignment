//
//  SecondTableViewCell.swift
//  BookWishList
//
//  Created by CaliaPark on 5/6/24.
//

import UIKit

protocol CollectionViewCellDelegate {
    func didSelectBook(book: Document)
}

class FirstTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    static let identifier = "FirstTableViewCell"
    
    var delegate: CollectionViewCellDelegate?
    
    let apiManager = APIManager()
    
    var collectionView: UICollectionView!
    
    var recentBookList: [Document] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 70)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: FirstCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentBookList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstCollectionViewCell.identifier, for: indexPath) as! FirstCollectionViewCell
        let book = recentBookList[indexPath.row]
        apiManager.fetchThumbnail(imageUrl: book.thumbnail) { image in
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = recentBookList[indexPath.row]
        delegate?.didSelectBook(book: book)
    }
}
