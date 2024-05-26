//
//  ListKind.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/24/24.
//

import Foundation
struct CurrnetList {
    @UserDefaultsWrapper(key: .listKind, defaultValue: .todo)
    var currentKind: ListKind
}

enum ListKind: Codable, CaseIterable {
    case shopping, todo
    
    var title: String {
        switch self {
        case .shopping:
            "쇼핑"
        case .todo:
            "할일"
        }
    }
    
    var imageName: String {
        switch self {
        case .shopping:
            "basket"
        case .todo:
            "pencil.and.list.clipboard"
        }
    }
}
