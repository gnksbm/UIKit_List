//
//  RecordViewController.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import UIKit

final class RecordViewController: UITableViewController {
    private var shoppingList = ShoppingList()
    private var todoList = TodoList()
    private var listKind = CurrnetList()
    
    @IBOutlet var textFieldBackgroundView: UIView!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureTableView()
        configureNavigation()
    }
    
    private func configureTextField() {
        textFieldBackgroundView.layer.cornerRadius = 10
    }
    
    private func configureTableView() {
        tableView.register(
            RecordTableViewCell.self
        )
    }
    
    private func configureNavigation() {
        let children = ListKind.allCases.map { kind in
            UIAction(
                title: kind.title,
                image: UIImage(systemName: kind.imageName)
            ) { _ in
                self.listKind.currentKind = kind
                self.title = kind.title
                self.tableView.reloadData()
            }
        }
        let menu = UIMenu(
            title: "선택",
            image: UIImage(systemName: "checklist"),
            children: children
        )
        navigationItem.rightBarButtonItem = .init(
            title: listKind.currentKind.title,
            image: UIImage(systemName: "checklist"),
            menu: menu
        )
        title = listKind.currentKind.title
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        do {
            guard let message = textField.text else { return }
            switch listKind.currentKind {
            case .shopping:
                let newItem = ShoppingModel(message: message)
                try newItem.validateMessage()
                shoppingList.shoppingList.insert(newItem, at: 0)
            case .todo:
                let newItem = TodoModel(description: message)
                try newItem.validateMessage()
                todoList.todoList.insert(newItem, at: 0)
            }
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc private func checkButtonTapped(_ sender: UIButton) {
        switch listKind.currentKind {
        case .shopping:
            shoppingList.shoppingList.toggleCheckMark(index: sender.tag)
        case .todo:
            todoList.todoList.toggleCheckMark(index: sender.tag)
        }
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {
        switch listKind.currentKind {
        case .shopping:
            shoppingList.shoppingList.toggleStar(index: sender.tag)
        case .todo:
            todoList.todoList.toggleStar(index: sender.tag)
        }
    }
}

extension RecordViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch listKind.currentKind {
        case .shopping:
            shoppingList.shoppingList.count
        case .todo:
            todoList.todoList.count
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            RecordTableViewCell.self,
            for: indexPath
        )
        var list: [RecordCellState]
        switch listKind.currentKind {
        case .shopping:
            list = shoppingList.shoppingList
        case .todo:
            list = todoList.todoList
        }
        cell.configureCell(state: list[indexPath.row], index: indexPath.row)
        cell.addStarButtonTarget(self, action: #selector(starButtonTapped))
        cell.addCheckButtonTarget(self, action: #selector(checkButtonTapped))
        return cell
    }
}
