//
//  ThirdViewController.swift
//  BookWishList
//
//  Created by CaliaPark on 5/4/24.
//

import UIKit

class WishListViewController: UIViewController {

    var deleteButton: UIButton = {
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
        setupTableView()
        configureUI()
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
        
    }
    
    @objc func addButtonTapped() {
        
    }
}

extension WishListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.identifier, for: indexPath) as! WishListTableViewCell
        cell.selectionStyle = .none
        return cell
    }

}
