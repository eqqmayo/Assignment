//
//  ViewController.swift
//  WishList
//
//  Created by CaliaPark on 4/28/24.
//

import UIKit

class ViewController: BaseViewController {
    
    var productList: [Product] = []

    let apiManager = APIManager()

    lazy var thumnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
        
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "상품명"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "상품설명"
        label.numberOfLines = 5
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$2,000"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        return label
    }()
    
    var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemMint
        button.setTitle("위시리스트 담기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemYellow
        button.setTitle("다른 상품 보기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView1: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [addButton, nextButton])
        stview.spacing = 10
        stview.axis = .horizontal
        stview.distribution = .fillEqually
        stview.alignment = .fill
        return stview
    }()
    
    var wishListButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemGray3
        button.setTitle("위시리스트 보기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(wishListButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView2: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [stackView1, wishListButton])
        stview.spacing = 10
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .fill
        return stview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNaviBar()
        setupData()
        print(productList)
    }
    
    // SnapKit 연습
    override func setupConstraints() {
    
        view.addSubview(thumnailImageView)
        thumnailImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(100)
            make.width.equalToSuperview()
            make.height.equalTo(thumnailImageView.snp.width)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumnailImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(140)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(thumnailImageView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
        }
        
        view.addSubview(stackView2)
        stackView2.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(100)
        }
    }
    
    func setupNaviBar() {
        title = "상품 보기"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupData() {
        apiManager.fetchProducts { products in
            if let products = products {
                self.productList.append(contentsOf: products)
                print(products)
                DispatchQueue.main.async {
                    self.setupProduct(id: 13)
                }
            } else {
                print("setupData failed")
            }
        }
    }
    
    func setupProduct(id: Int) {
        let product = productList[id]
        apiManager.fetchImage(imageUrl: product.thumbnail) { image in
            DispatchQueue.main.async {
                self.thumnailImageView.image = image
            }
        }
        titleLabel.text = product.title
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedNumber = formatter.string(from: NSNumber(value: product.price)) {
            priceLabel.text = "$" + formattedNumber
        }
        descriptionLabel.text = product.description
    }
    
    @objc func addButtonTapped() {
        
    }
    
    @objc func nextButtonTapped() {
        let id = Int.random(in: 0...29)
        setupProduct(id: id)
    }
    
    @objc func wishListButtonTapped() {
        let wishListVC = WishListViewController()
        wishListVC.modalPresentationStyle = .fullScreen
        self.show(wishListVC, sender: nil)
    }
}

