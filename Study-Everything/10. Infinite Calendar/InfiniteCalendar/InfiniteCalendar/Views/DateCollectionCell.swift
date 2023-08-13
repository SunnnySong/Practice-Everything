//
//  DateCollectionCell.swift
//  InfiniteCalendar
//
//  Created by Sunny on 2023/08/09.
//

import UIKit

final class DateCollectionCell: UICollectionViewCell {

    private var days: [DayComponent]?

    private lazy var calendar: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let cellWidth = self.bounds.width / 7
        let cellHeight = self.bounds.height / 6
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(DateCell.self)
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    // MARK: Lifecycle
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)

        configureHierarchy()
    }

    // MARK: Functions - Public
    func configure(with dayComponent: [DayComponent]) {
        self.days = dayComponent
    }

    // MARK: Functions - Private
    private func configureHierarchy() {
        contentView.addSubview(calendar)
        calendar.frame = contentView.bounds

        calendar.dataSource = self
//        calendar.delegate = self
    }
}

extension DateCollectionCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        guard let days = days else { return 30 }
        return days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dateCell: DateCell = collectionView.dequeue(for: indexPath)

        guard let days = days else { return UICollectionViewCell() }
        dateCell.configure(with: days[indexPath.row])

        return dateCell
    }
}
