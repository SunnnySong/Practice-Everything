//
//  CalendarView.swift
//  InfiniteCalendar
//
//  Created by Sunny on 2023/08/08.
//

import UIKit

final class CalendarView: UICollectionView {

    var closure: ((IndexPath) -> ())?

    // MARK: Lifecycle
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        self.collectionViewLayout = createLayout()
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        self.register(DateCell.self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions - Private
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionNum, env) -> NSCollectionLayoutSection? in

            let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth((1.0 / 7)), heightDimension: .fractionalHeight(1.0))
            let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight((1.0 / 7)))
            let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 7)

            let groupSize2: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight((1.0)))
            let group2: NSCollectionLayoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize2, repeatingSubitem: group, count: 6)

            let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group2)

            section.orthogonalScrollingBehavior = .paging
            section.visibleItemsInvalidationHandler = { [weak self] visibleItems, offset, env in

                guard let currentIndex = visibleItems.last?.indexPath,
                      visibleItems.last?.indexPath.section == 0 else { return }

                self?.closure?(currentIndex)
            }
            return section
        }
        return layout
    }
}

