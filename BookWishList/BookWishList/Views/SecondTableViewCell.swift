//
//  SearchResultTableViewCell.swift
//  BookWishList
//
//  Created by CaliaPark on 5/4/24.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    
    static let identifier = "SecondTableViewCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "삼국지삼국지삼국지"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    var writerLabel: UILabel = {
        let label = UILabel()
        label.text = "나관중"
        label.textAlignment = .right
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [titleLabel, writerLabel])
        stview.spacing = 10
        stview.axis = .horizontal
        stview.distribution = .fillProportionally
        stview.alignment = .fill
        return stview
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
        
    func configureUI() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-10)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
