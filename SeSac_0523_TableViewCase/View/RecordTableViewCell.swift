//
//  RecordTableViewCell.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import UIKit

final class RecordTableViewCell: UITableViewCell {
    private var prepareCheckButtonClosure: (() -> Void) = { }
    private var prepareStarButtonClosure: (() -> Void) = { }
    
    private let cellBackgroundView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.layer.cornerRadius = 10
        return view
    }()
    private lazy var checkButton = {
        let button = UIButton()
        button.tintColor = .black
        return button
    }()
    private let messageLabel = UILabel()
    private lazy var starButton = {
        let button = UIButton()
        button.tintColor = .black
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkButton.setImage(nil, for: .normal)
        messageLabel.text = nil
        starButton.setImage(nil, for: .normal)
        prepareCheckButtonClosure()
        prepareStarButtonClosure()
    }
    
    func configureCell(state: RecordCellState, index: Int) {
        let checkImageName = state.isChecked ? "checkmark.square.fill" : "checkmark.square"
        checkButton.setImage(
            .init(systemName: checkImageName),
            for: .normal
        )
        checkButton.tag = index
        messageLabel.text = state.message
        let starImageName = state.isStarred ? "star.fill" : "star"
        starButton.setImage(
            .init(systemName: starImageName),
            for: .normal
        )
        starButton.tag = index
    }
    
    func addCheckButtonTarget(_ target: Any?, action: Selector) {
        checkButton.addTarget(target, action: action, for: .touchUpInside)
        prepareCheckButtonClosure = {
            self.checkButton.removeTarget(
                target,
                action: action,
                for: .touchUpInside
            )
        }
    }
    
    func addStarButtonTarget(_ target: Any?, action: Selector) {
        starButton.addTarget(target, action: action, for: .touchUpInside)
        prepareStarButtonClosure = {
            self.starButton.removeTarget(
                target,
                action: action,
                for: .touchUpInside
            )
        }
    }
    
    private func configureUI() {
        [
            cellBackgroundView,
            checkButton,
            messageLabel,
            starButton,
        ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 3
            ),
            cellBackgroundView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            cellBackgroundView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),
            cellBackgroundView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -3
            ),
            
            checkButton.topAnchor.constraint(
                equalTo: cellBackgroundView.topAnchor,
                constant: 20
            ),
            checkButton.leadingAnchor.constraint(
                equalTo: cellBackgroundView.leadingAnchor,
                constant: 30
            ),
            checkButton.widthAnchor.constraint(
                equalToConstant: 30
            ),
            checkButton.bottomAnchor.constraint(
                equalTo: cellBackgroundView.bottomAnchor,
                constant: -20
            ),
            
            messageLabel.leadingAnchor.constraint(
                equalTo: checkButton.trailingAnchor,
                constant: 30
            ),
            messageLabel.centerYAnchor.constraint(
                equalTo: checkButton.centerYAnchor
            ),
            
            starButton.leadingAnchor.constraint(
                equalTo: messageLabel.trailingAnchor,
                constant: 20
            ),
            starButton.trailingAnchor.constraint(
                equalTo: cellBackgroundView.trailingAnchor,
                constant: -20
            ),
            starButton.widthAnchor.constraint(
                equalTo: checkButton.widthAnchor
            ),
            starButton.centerYAnchor.constraint(
                equalTo: checkButton.centerYAnchor
            ),
        ])
    }
}
