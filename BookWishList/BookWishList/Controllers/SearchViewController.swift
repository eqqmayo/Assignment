//
//  ViewController.swift
//  BookWishList
//
//  Created by CaliaPark on 5/4/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

    let apiManager = APIManager()
    
    var bookList: [Document] = []
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.searchBarStyle = .minimal
        bar.showsCancelButton = true
        bar.placeholder = "찾고 싶은 책 제목을 입력하세요"
        bar.searchTextField.backgroundColor = #colorLiteral(red: 0.9459868073, green: 0.9459868073, blue: 0.9459868073, alpha: 1)
        bar.searchTextField.borderStyle = .roundedRect
        return bar
    }()
    
    var recentBookLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 본 책"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    var collectionView: UICollectionView!
    
    var searchResultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchBar()
        setupCollectionView()
        setupTableView()
        configureUI()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        self.view.addSubview(tableView)
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    func configureUI() {
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(recentBookLabel)
        recentBookLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(recentBookLabel.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
        
        self.view.addSubview(searchResultLabel)
        searchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchResultLabel.snp.bottom).offset(15)
            make.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
            if searchBar.text != nil {
                self.apiManager.fetchBookData(with: searchBar.text!) { books in
                    DispatchQueue.main.async {
                        if let books = books {
                            self.bookList = books
                            self.tableView.reloadData()
                            
                            if self.bookList.isEmpty {
                                let alert = UIAlertController(title: "검색 결과", message: "찾으시는 도서가 존재하지 않습니다", preferredStyle: .alert)
                                let cancel = UIAlertAction(title: "닫기", style: .cancel)
                                alert.addAction(cancel)
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            }
        }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        return cell
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let book = bookList[indexPath.row]
        cell.titleLabel.text = book.title
        cell.writerLabel.text = book.authors.joined(separator: ",")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let book = bookList[indexPath.row]
        detailVC.titleLabel.text = book.title
        detailVC.writerLabel.text = book.authors.joined(separator: ",")
        apiManager.fetchThumbnail(imageUrl: book.thumbnail) { image in
            DispatchQueue.main.async {
                detailVC.thumbnailImageView.image = image
            }
        }
        detailVC.priceLabel.text = "\(book.salePrice)원"
        detailVC.descriptionLabel.text = book.contents
        present(detailVC, animated: true)
    }
}
