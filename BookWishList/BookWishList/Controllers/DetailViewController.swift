//
//  SecondViewController.swift
//  BookWishList
//
//  Created by CaliaPark on 5/4/24.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var container: NSPersistentContainer!
    
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
        imageView.contentMode = .scaleAspectFit
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
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
       return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("담기", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
       return button
    }()
    
    lazy var contentStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [titleLabel, writerLabel, thumbnailImageView, priceLabel, descriptionLabel])
        stview.spacing = 10
        stview.axis = .vertical
        stview.alignment = .center
        stview.distribution = .equalSpacing
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
            make.width.equalTo(300)
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
            make.top.equalTo(contentStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
       
        let context = container.viewContext
    
        let fetchRequest = WishBook.fetchRequest()
        let predicate = NSPredicate(format: "title == %@ AND writer == %@ AND price == %@", titleLabel.text ?? "", writerLabel.text ?? "", priceLabel.text ?? "")
        fetchRequest.predicate = predicate
            
        do {
            let result = try context.fetch(fetchRequest)
            if result.isEmpty {
                let book = WishBook(context: context)
                book.title = titleLabel.text
                book.writer = writerLabel.text
                book.price = priceLabel.text
                try context.save()
            }
        } catch {
            print(error)
        }
    }
}
