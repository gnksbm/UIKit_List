//
//  SettingViewController.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 7/19/24.
//

import UIKit

final class SettingViewController: UIViewController {
    private lazy var collectionView = SettingCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        collectionView.updateSnapshot()
    }
    
    private func configureLayout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}
