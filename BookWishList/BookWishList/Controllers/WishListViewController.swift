//
//  ThirdViewController.swift
//  BookWishList
//
//  Created by CaliaPark on 5/4/24.
//

import UIKit
import CoreData

class WishListViewController: UIViewController {
    
    var bookWishList: [WishBook] = []
    
    var container: NSPersistentContainer!

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.contentHorizontalAlignment = .left
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "담은 책"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [deleteButton, mainLabel, addButton])
        stview.axis = .horizontal
        stview.alignment = .fill
        stview.distribution = .equalCentering
        return stview
    }()
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupData()
        setupTableView()
        configureUI()
    }
    
    func setupData() {
        let request = WishBook.fetchRequest()
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            self.container = appDelegate.persistentContainer
            
            let wishList = try self.container.viewContext.fetch(request)
            bookWishList = wishList
        } catch {
            print(error)
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        self.view.addSubview(tableView)
        self.tableView.register(WishListTableViewCell.self, forCellReuseIdentifier: WishListTableViewCell.identifier)
    }
    
    func configureUI() {
        deleteButton.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(15)
            make.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    @objc func deleteButtonTapped() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishBook")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        setupData()
        tableView.reloadData()
    }
    
    @objc func addButtonTapped() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0
            if let searchVC = tabBarController.viewControllers?.first as? SearchViewController {
                searchVC.searchBar.becomeFirstResponder()
            }
        }
    }
}

extension WishListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookWishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.identifier, for: indexPath) as! WishListTableViewCell
        let book = bookWishList[indexPath.row]
        cell.titleLabel.text = book.title
        cell.writerLabel.text = book.writer
        cell.priceLabel.text = book.price
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let bookToDelete = bookWishList[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(bookToDelete)
            
            do {
                try context.save()
            } catch {
                print(error)
            }
            bookWishList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
