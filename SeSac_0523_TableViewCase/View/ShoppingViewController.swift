//
//  ShoppingViewController.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import UIKit

final class ShoppingViewController: UITableViewController {
    @UserDefaultsWrapper(key: "shoppingList", defaultValue: [])
    private var shoppingList: [ShoppingModel]
    
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
            ShoppingTableViewCell.self,
            forCellReuseIdentifier: ShoppingTableViewCell.identifier
        )
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        do {
            try shoppingList.addNewItem(message: textField.text)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ShoppingViewController {
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
            withIdentifier: ShoppingTableViewCell.identifier,
            for: indexPath
        ) as? ShoppingTableViewCell else { return .init() }
        cell.updateUI(model: shoppingList[indexPath.row])
        cell.setCheckButtonClosure {
            self.shoppingList.togglePurchased(index: indexPath.row)
            tableView.reloadData()
        }
        cell.setFavoriteButtonClosure {
            self.shoppingList.toggleFavorite(index: indexPath.row)
            tableView.reloadData()
        }
        return cell
    }
}
