//
//  ViewController.swift
//  ToDoList
//
//  Created by CaliaPark on 3/18/24.
//

import UIKit

class ViewController: UIViewController {
   
    var todoList: [Todo] = [Todo(title: "추가하기를 눌러 할 일을 추가하세요", isDone: false, isHighlighted: false),
                            Todo(title: "스위치를 눌러 할 일을 완료하세요 ", isDone: false, isHighlighted: false),
                            Todo(title: "왼쪽으로 스와이프해 할 일을 삭제/공유하세요", isDone: false, isHighlighted: false),
                            Todo(title: "오른쪽으로 스와이프해 할 일을 강조하세요", isDone: false, isHighlighted: false)]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        setupTableView()
        setupTableViewConstraints()
    }

    func setupNaviBar() {
        title = "할 일 목록"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let add = UIBarButtonItem(title: "추가하기", image: nil, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = add
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
            
        let nibName = UINib(nibName: "MyTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MyCell")
    }
        
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "할 일 추가", message: "할 일을 입력하세요", preferredStyle: .alert)
        
        alert.addTextField { tf in
            tf.placeholder = "할 일 입력"
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { action in
            if let txt = alert.textFields?[0] {
                if txt.text?.isEmpty != true {
                    let todoData = Todo(title: txt.text!, isDone: false, isHighlighted: false)
                    self.todoList.append(todoData)
                    self.tableView.reloadData()
                } else {
                    alert.textFields?.first?.placeholder = "Enter something!"
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)

        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyTableViewCell
        let todo = todoList[indexPath.row]
        if todo.isDone {
            cell.todoLabel.attributedText = todo.title.strikeThrough()
            cell.todoLabel.textColor = .gray
        } else {
            cell.todoLabel.attributedText = NSAttributedString(string: todo.title)
            cell.todoLabel.textColor = .black
        }
        cell.isDoneSwitch.isOn = todo.isDone
        cell.isDoneSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        if todo.isHighlighted && !todo.isDone {
            cell.todoLabel.textColor = .red
        } else if !todo.isHighlighted && !todo.isDone {
            cell.todoLabel.textColor = .black
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        let point = sender.convert(CGPoint.zero, to: self.tableView)
        if let indexPath = self.tableView.indexPathForRow(at: point) {
            todoList[indexPath.row].isDone = !todoList[indexPath.row].isDone
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let share = UIContextualAction(style: .normal, title: "Share") { (_, _, success: @escaping (Bool) -> Void) in
            success(true)
        }
        let delete = UIContextualAction(style: .normal, title: "Delete") { (_, _, success: @escaping (Bool) -> Void) in
            self.todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            success(true)
        }
        share.backgroundColor = .systemBlue
        share.image = UIImage(systemName: "square.and.arrow.up")
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete, share])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let highlight = UIContextualAction(style: .normal, title: "Star") { [self] (_, _, success: @escaping (Bool) -> Void) in
            self.todoList[indexPath.row].isHighlighted = !self.todoList[indexPath.row].isHighlighted
            tableView.reloadRows(at: [indexPath], with: .none)
            success(true)
        }
        highlight.backgroundColor = .systemGreen
        highlight.image = UIImage(systemName: "star.fill")
        
        return UISwipeActionsConfiguration(actions: [highlight])
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}


