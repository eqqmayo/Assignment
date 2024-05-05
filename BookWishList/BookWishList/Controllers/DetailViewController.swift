//
//  SecondViewController.swift
//  BookWishList
//
//  Created by CaliaPark on 5/4/24.
//

import UIKit

class DetailViewController: UIViewController {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "삼국지"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    var writerLabel: UILabel = {
        let label = UILabel()
        label.text = "나관중"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "20,000원"
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "blablabla"
        label.numberOfLines = 15
        return label
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
       return button
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("담기", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 20
       return button
    }()
    
    lazy var contentStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [titleLabel, writerLabel, thumbnailImageView, priceLabel, descriptionLabel])
        stview.spacing = 2
        stview.axis = .vertical
        stview.alignment = .center
        stview.distribution = .fillProportionally
        return stview
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [cancelButton, addButton])
        stview.spacing = 10
        stview.axis = .horizontal
        stview.alignment = .fill
        stview.distribution = .fillEqually
        return stview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    func configureUI() {
        [contentStackView, buttonStackView].forEach { view.addSubview($0) }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-120)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(contentStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
