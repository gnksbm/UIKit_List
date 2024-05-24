//
//  RecordMessageError.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import Foundation

enum RecordMessageError: LocalizedError {
    case emptyMessage, onlyWhitespace
    
    var errorDescription: String? {
        switch self {
        case .emptyMessage:
            "입력이 비었습니다"
        case .onlyWhitespace:
            "입력은 공백만 포함할 수 없습니다"
        }
    }
}
