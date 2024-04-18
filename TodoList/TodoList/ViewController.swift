//
//  ViewController.swift
//  ToDoList
//
//  Created by CaliaPark on 3/18/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var todoArray: [Todo] = [
        Todo(title: "+ 버튼을 눌러 할 일을 추가하세요", isDone: false, isHighlighted: false),
        Todo(title: "스위치를 눌러 할 일을 완료하세요 ", isDone: false, isHighlighted: false),
        Todo(title: "왼쪽으로 스와이프해 할 일을 삭제하세요", isDone: false, isHighlighted: false),
        Todo(title: "오른쪽으로 스와이프해 할 일을 강조하세요", isDone: false, isHighlighted: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = "할 일 목록"
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
        let add = UIAlertAction(title: "확인", style: .default) { _ in
            if let tf = alert.textFields?[0] {
                if tf.text?.isEmpty == false {
                    let todoData = Todo(title: tf.text!, isDone: false, isHighlighted: false)
                    self.todoArray.append(todoData)
                    self.tableView.reloadData()
                }
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(add)
        alert.addAction(cancel)
        alert.addTextField { tf in
            tf.placeholder = "할 일을 추가하세요"
        }
        self.present(alert, animated: false)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TableViewCell
        cell.titleLabel.text = todoArray[indexPath.row].title
        cell.titleLabel.textColor = todoArray[indexPath.row].isHighlighted ? .systemRed : .black
        cell.dateLabel.text = todoArray[indexPath.row].date
//        cell.isDoneSwitch.isOn = todoArray[indexPath.row].isDone
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            todoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let highlight = UIContextualAction(style: .normal, title: "중요") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.todoArray[indexPath.row].isHighlighted = self.todoArray[indexPath.row].isHighlighted ? false : true
            tableView.reloadRows(at: [indexPath], with: .none)
            success(true)
        }
        highlight.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [highlight])
    }
}

