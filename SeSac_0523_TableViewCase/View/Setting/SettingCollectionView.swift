//
//  SettingCollectionView.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 7/19/24.
//

import UIKit

final class SettingCollectionView: UICollectionView {
    private var diffableDataSource: DataSource!
    
    private let compotisionalLayout =
    UICollectionViewCompositionalLayout { _, env in
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.headerMode = .supplementary
        return NSCollectionLayoutSection.list(
            using: config,
            layoutEnvironment: env
        )
    }
    
    init() {
        super.init(
            frame: .zero,
            collectionViewLayout: compotisionalLayout
        )
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        let allSection = CollectionViewSection.allCases
        snapshot.appendSections(allSection)
        allSection.forEach { section in
            switch section {
            case .all:
                snapshot.appendItems(
                    CollectionViewItem.allSectionItems,
                    toSection: section
                )
            case .personal:
                snapshot.appendItems(
                    CollectionViewItem.personalSectionItems,
                    toSection: section
                )
            case .etc:
                snapshot.appendItems(
                    CollectionViewItem.etcSectionItems,
                    toSection: section
                )
            }
        }
        diffableDataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        let cellRegistration = makeCellRegistration()
        let headerRegistration = makeHeaderRegistration()
        
        diffableDataSource = DataSource(
            collectionView: self
        ) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
        register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "UICollectionReusableView"
        )
        diffableDataSource.supplementaryViewProvider =
        { collectionView, elementKind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath
            )
        }
    }
    
    private func makeCellRegistration() -> CellRegistration {
        CellRegistration { cell, indexPath, item in
            var config = UIListContentConfiguration.cell()
            config.text = item.title
            cell.contentConfiguration = config
        }
    }
    
    private func makeHeaderRegistration() -> HeaderRegistraition {
        HeaderRegistraition(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { view, kind, indexPath in
            var config = UIListContentConfiguration.plainHeader()
            config.text =
            CollectionViewSection.allCases[indexPath.section].title
            view.contentConfiguration = config
        }
    }
}

extension SettingCollectionView {
    typealias DataSource =
    UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>
    
    typealias Snapshot =
    NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>
    
    typealias CellRegistration =
    UICollectionView.CellRegistration<UICollectionViewCell, CollectionViewItem>
    
    typealias HeaderRegistraition =
    UICollectionView.SupplementaryRegistration<UICollectionViewCell>
    
    enum CollectionViewSection: CaseIterable {
        case all, personal, etc
        
        var title: String {
            switch self {
            case .all:
                "전체 설정"
            case .personal:
                "개인 설정"
            case .etc:
                "기타"
            }
        }
    }
    
    struct CollectionViewItem: Hashable {
        static let allSectionItems: [Self] = [
            Self(title: "공지사항"),
            Self(title: "실험실"),
            Self(title: "버전 정보"),
        ]
        
        static let personalSectionItems: [Self] = [
            Self(title: "개인/보안"),
            Self(title: "알림"),
            Self(title: "채팅"),
            Self(title: "멀티프로필"),
        ]
        
        static let etcSectionItems: [Self] = [
            Self(title: "고객센터/도움말")
        ]
        
        let title: String
    }
}
