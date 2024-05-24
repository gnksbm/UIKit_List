//
//  RecordViewController.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import UIKit

final class RecordViewController: UITableViewController {
    private var shoppingList = UserDefaultsManager.shoppingList
    
    @IBOutlet var textFieldBackgroundView: UIView!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureTableView()
    }
    
    private func configureTextField() {
        textFieldBackgroundView.layer.cornerRadius = 10
    }
    
    private func configureTableView() {
        tableView.register(
            RecordTableViewCell.self,
            forCellReuseIdentifier: RecordTableViewCell.identifier
        )
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        do {
            guard let message = textField.text else { return }
            let newItem = ShoppingModel(message: message)
            try shoppingList.validateMessage(element: newItem)
            shoppingList.insert(newItem, at: 0)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc private func checkButtonTapped(_ sender: UIButton) {
        shoppingList.toggleCheckMark(index: sender.tag)
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {
        shoppingList.toggleStar(index: sender.tag)
    }
}

extension RecordViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        shoppingList.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecordTableViewCell.identifier,
            for: indexPath
        ) as? RecordTableViewCell else { return .init() }
        let index = indexPath.row
        cell.configureCell(state: shoppingList[index], index: index)
        cell.addStarButtonTarget(self, action: #selector(starButtonTapped))
        cell.addCheckButtonTarget(self, action: #selector(checkButtonTapped))
        return cell
    }
}
