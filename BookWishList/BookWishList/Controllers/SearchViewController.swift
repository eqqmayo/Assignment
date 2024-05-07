//
//  ViewController.swift
//  BookWishList
//
//  Created by CaliaPark on 5/4/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, addAlertDelegate, CollectionViewCellDelegate {
    
    let apiManager = APIManager()
    var isInfiniteScroll = true
    var page = 1
    var isEnd = false
    
    let sections = ["최근 본 책", "검색 결과"]
    var resultBookList: [Document] = []
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.searchBarStyle = .minimal
        bar.showsCancelButton = true
        bar.placeholder = "찾고 싶은 책 제목을 입력하세요"
        bar.searchTextField.backgroundColor = #colorLiteral(red: 0.9459868073, green: 0.9459868073, blue: 0.9459868073, alpha: 1)
        bar.searchTextField.borderStyle = .roundedRect
        return bar
    }()
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchBar()
        setupTableView()
        configureUI()
    }
    
    func addAlert() {
        let alert = UIAlertController(title: "담기 완료", message: "위시리스트에 책을 담았습니다!", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "닫기", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func didSelectBook(book: Document) {
        let detailVC = DetailViewController()
        detailVC.delegate = self
        detailVC.titleLabel.text = book.title
        detailVC.writerLabel.text = book.authors.joined(separator: ",")
        
        apiManager.fetchThumbnail(imageUrl: book.thumbnail) { image in
            DispatchQueue.main.async {
                detailVC.thumbnailImageView.image = image
            }
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedNumber = formatter.string(from: NSNumber(value: book.salePrice)) {
            detailVC.priceLabel.text = formattedNumber + "원"
        }
        detailVC.descriptionLabel.text = book.contents
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        self.tableView.register(FirstTableViewCell.self, forCellReuseIdentifier: FirstTableViewCell.identifier)
        self.tableView.register(SecondTableViewCell.self, forCellReuseIdentifier: SecondTableViewCell.identifier)
    }
    
    func configureUI() {
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        page = 1
        isEnd = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != nil {
            self.apiManager.fetchBookData(with: searchBar.text!, to: page) { books in
                DispatchQueue.main.async {
                    if let books = books {
                        self.resultBookList = books.documents
                        self.tableView.reloadData()
                    }
                    if self.resultBookList.isEmpty {
                        let alert = UIAlertController(title: "검색 결과", message: "찾으시는 도서가 존재하지 않습니다", preferredStyle: .alert)
                        let cancel = UIAlertAction(title: "닫기", style: .cancel)
                        alert.addAction(cancel)
                        self.present(alert, animated: true, completion: nil)
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 5, width: tableView.bounds.size.width, height: 25))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 25)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerView.addSubview(headerLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return resultBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier, for: indexPath) as! FirstTableViewCell
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.identifier, for: indexPath) as! SecondTableViewCell
            let book = resultBookList[indexPath.row]
            cell.titleLabel.text = book.title
            cell.writerLabel.text = book.authors.joined(separator: ",")
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            let book = resultBookList[indexPath.row]
            
            if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FirstTableViewCell {
                if !cell.recentBookList.contains(book) {
                    if cell.recentBookList.count < 10 {
                        cell.recentBookList.insert(book, at: 0)
                    } else {
                        cell.recentBookList.removeLast()
                        cell.recentBookList.insert(book, at: 0)
                    }
                    cell.collectionView.reloadData()
                }
            }
            
            let detailVC = DetailViewController()
            detailVC.delegate = self
            detailVC.titleLabel.text = book.title
            detailVC.writerLabel.text = book.authors.joined(separator: ",")
            
            apiManager.fetchThumbnail(imageUrl: book.thumbnail) { image in
                DispatchQueue.main.async {
                    detailVC.thumbnailImageView.image = image
                }
            }
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let formattedNumber = formatter.string(from: NSNumber(value: book.salePrice)) {
                detailVC.priceLabel.text = formattedNumber + "원"
            }
            detailVC.descriptionLabel.text = book.contents
            present(detailVC, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            if isInfiniteScroll && !isEnd {
                isInfiniteScroll = false
                self.page += 1
                self.apiManager.fetchBookData(with: searchBar.text!, to: page) { books in
                    DispatchQueue.main.async {
                        if let books = books {
                            self.resultBookList.append(contentsOf: books.documents)
                            self.isEnd = books.isEnd
                            self.tableView.reloadData()
                        }
                        self.isInfiniteScroll = true
                    }
                }
            }
        }
    }
}
