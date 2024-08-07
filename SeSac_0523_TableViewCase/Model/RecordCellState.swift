//
//  RecordCellState.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/24/24.
//

import Foundation

protocol RecordCellState: Codable {
    var isChecked: Bool { get set }
    var message: String { get }
    var isStarred: Bool { get set }
}

extension RecordCellState {
    func validateMessage() throws {
        guard !message.isEmpty else { throw RecordMessageError.emptyMessage }
        guard !message
            .replacingOccurrences(of: " ", with: "")
            .isEmpty else { throw RecordMessageError.onlyWhitespace }
    }
}

extension Array where Element: RecordCellState {
    mutating func toggleStar(index: Int) {
        var updatedElement = remove(at: index)
        updatedElement.isStarred.toggle()
        insert(updatedElement, at: index)
    }
    
    mutating func toggleCheckMark(index: Int) {
        var updatedElement = remove(at: index)
        updatedElement.isChecked.toggle()
        insert(updatedElement, at: index)
    }
}
