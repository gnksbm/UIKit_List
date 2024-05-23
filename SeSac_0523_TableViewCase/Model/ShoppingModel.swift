//
//  ShoppingModel.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import Foundation

struct ShoppingModel: Codable {
    var isPurchased: Bool
    let message: String
    var isFavorite: Bool
    
    init(
        isPurchased: Bool = false,
        message: String,
        isFavorite: Bool = false
    ) {
        self.isPurchased = isPurchased
        self.message = message
        self.isFavorite = isFavorite
    }
}

extension Array where Element == ShoppingModel {
    mutating func toggleFavorite(index: Int) {
        var updatedElement = remove(at: index)
        updatedElement.isFavorite.toggle()
        insert(updatedElement, at: index)
    }
    
    mutating func togglePurchased(index: Int) {
        var updatedElement = remove(at: index)
        updatedElement.isPurchased.toggle()
        insert(updatedElement, at: index)
    }
    
    mutating func addNewItem(message: String?) throws {
        guard let message else { throw ShoppingModelError.unknown }
        guard !message.isEmpty else { throw ShoppingModelError.emptyMessage }
        let newItem = Element(message: message)
        self.insert(newItem, at: 0)
    }
}
