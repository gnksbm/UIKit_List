//
//  TodoModel.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/24/24.
//

import Foundation

struct TodoList {
    @UserDefaultsWrapper(key: .todoList, defaultValue: [])
    var todoList: [TodoModel]
}
struct TodoModel {
    var isDone: Bool
    let deadLine: Date
    let description: String
    var isStarred: Bool
    
    init(
        isDone: Bool = false,
        deadLine: Date = .now.addingTimeInterval(86400 * 7),
        description: String,
        isStarred: Bool = false
    ) {
        self.isDone = isDone
        self.deadLine = deadLine
        self.description = description
        self.isStarred = isStarred
    }
}

extension TodoModel: RecordCellState {
    var isChecked: Bool {
        get {
            deadLine.distance(to: .now) > 0 || isDone
        }
        set {
            isDone = newValue
        }
    }
    
    var message: String {
        description
    }
}
