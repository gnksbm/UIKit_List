//
//  ShoppingTableViewCell.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import UIKit

final class ShoppingTableViewCell: UITableViewCell {
    private var checkButtonClosure: (() -> Void)?
    private var favoriteButtonClosure: (() -> Void)?
    
    private let cellBackgroundView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.layer.cornerRadius = 10
        return view
    }()
    private lazy var checkButton = {
        let button = UIButton()
        button.tintColor = .black
        button.addTarget(
            self,
            action: #selector(checkButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    private let messageLabel = UILabel()
    private lazy var favoriteButton = {
        let button = UIButton()
        button.tintColor = .black
        button.addTarget(
            self,
            action: #selector(favoriteButtonTapped),
            for: .touchUpInside
        )
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
        favoriteButton.setImage(nil, for: .normal)
        checkButtonClosure = nil
        favoriteButtonClosure = nil
    }
    
    func updateUI(model: ShoppingModel) {
        let checkImageName = model.isPurchased ? "checkmark.square.fill" : "checkmark.square"
        checkButton.setImage(
            .init(systemName: checkImageName),
            for: .normal
        )
        messageLabel.text = model.message
        let favoriteImageName = model.isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(
            .init(systemName: favoriteImageName),
            for: .normal
        )
    }
    
    func setCheckButtonClosure(
        _ action: @escaping () -> Void
    ) {
        self.checkButtonClosure = action
    }
    
    func setFavoriteButtonClosure(
        _ action: @escaping () -> Void
    ) {
        self.favoriteButtonClosure = action
    }
    
    private func configureUI() {
        [
            cellBackgroundView,
            checkButton,
            messageLabel,
            favoriteButton,
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
            
            favoriteButton.leadingAnchor.constraint(
                equalTo: messageLabel.trailingAnchor,
                constant: 20
            ),
            favoriteButton.trailingAnchor.constraint(
                equalTo: cellBackgroundView.trailingAnchor,
                constant: -20
            ),
            favoriteButton.widthAnchor.constraint(
                equalTo: checkButton.widthAnchor
            ),
            favoriteButton.centerYAnchor.constraint(
                equalTo: checkButton.centerYAnchor
            ),
        ])
    }
    
    @objc private func checkButtonTapped() {
        checkButtonClosure?()
    }
    
    @objc private func favoriteButtonTapped() {
        favoriteButtonClosure?()
    }
}
