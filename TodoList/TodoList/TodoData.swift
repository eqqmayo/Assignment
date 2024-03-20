//
//  TodoData.swift
//  ToDoList
//
//  Created by CaliaPark on 3/18/24.
//

import Foundation

struct Todo {
    static var id = 0
    
    var title: String
    var isDone: Bool
    
    init(title: String, isDone: Bool) {
        self.title = title
        self.isDone = isDone
        Todo.id += 1
    }
}
