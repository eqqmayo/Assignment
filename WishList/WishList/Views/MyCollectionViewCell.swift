//
//  MyCollectionViewCell.swift
//  WishList
//
//  Created by CaliaPark on 4/28/24.
//

import UIKit
import SnapKit

class MyCollectionViewCell: UICollectionViewCell {
    
    let myProductLabel: UILabel = {
        let label = UILabel()
        label.text = "[1] iPhone 9 - 549$"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        self.contentView.addSubview(myProductLabel)
        myProductLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
        }
    }
        
}
