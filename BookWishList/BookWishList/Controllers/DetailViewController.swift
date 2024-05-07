//
//  SecondViewController.swift
//  BookWishList
//
//  Created by CaliaPark on 5/4/24.
//

import UIKit
import CoreData

protocol addAlertDelegate {
    func addAlert()
}

class DetailViewController: UIViewController {
    
    var delegate: addAlertDelegate?
    
    var container: NSPersistentContainer!
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    var contentView = UIView()
    
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
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "20,000원"
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "blablabla"
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 18)
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
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
       return button
    }()
    
    lazy var contentStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [titleLabel, writerLabel, thumbnailImageView, priceLabel])
        stview.spacing = 15
        stview.axis = .vertical
        stview.alignment = .center
        stview.distribution = .equalSpacing
        return stview
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [cancelButton, addButton])
        let ratioConstraint = NSLayoutConstraint(item: addButton, attribute: .width, relatedBy: .equal, toItem: cancelButton, attribute: .width, multiplier: 3, constant: 0)
        NSLayoutConstraint.activate([ratioConstraint])
        stview.spacing = 10
        stview.axis = .horizontal
        stview.alignment = .fill
        stview.distribution = .fill
        return stview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    func configureUI() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-90)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(30)
            make.leading.equalTo(contentView).offset(30)
            make.trailing.equalTo(contentView).offset(-30)
        }

        thumbnailImageView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(contentStackView.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(30)
            make.trailing.equalTo(contentView).offset(-30)
            make.bottom.equalTo(contentView).offset(-30)
        }
        
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.height.equalTo(60)
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
        self.dismiss(animated: true)
        delegate?.addAlert()
    }
}
