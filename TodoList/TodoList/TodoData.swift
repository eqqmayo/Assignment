//
//  TodoData.swift
//  ToDoList
//
//  Created by CaliaPark on 3/18/24.
//

import Foundation

struct Todo {
    
    var title: String
    var isDone: Bool
    var isHighlighted: Bool
    var date: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
