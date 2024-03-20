//
//  ViewController.swift
//  ToDoList
//
//  Created by CaliaPark on 3/18/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var todoArray: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = "할 일 목록"
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
        let add = UIAlertAction(title: "추가", style: .default) { _ in
            if let tf = alert.textFields?[0] {
                if tf.text?.isEmpty == false {
                    let todoData = Todo(title: tf.text!, isDone: false)
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
        cell.isDoneSwitch.isOn = todoArray[indexPath.row].isDone
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
}

