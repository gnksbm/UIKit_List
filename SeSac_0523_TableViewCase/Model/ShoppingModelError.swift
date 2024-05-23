//
//  ShoppingModelError.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import Foundation

enum ShoppingModelError: LocalizedError {
    case unknown, emptyMessage
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            "알 수 없는 에러"
        case .emptyMessage:
            "쇼핑 내용이 비었습니다"
        }
    }
}
