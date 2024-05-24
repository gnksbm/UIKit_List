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


extension ShoppingModel: RecordCellState {
    var isChecked: Bool {
        get {
            isPurchased
        }
        set {
            isPurchased = newValue
        }
    }
    
    var isStarred: Bool {
        get {
            isFavorite
        }
        set {
            isFavorite = newValue
        }
    }
}
