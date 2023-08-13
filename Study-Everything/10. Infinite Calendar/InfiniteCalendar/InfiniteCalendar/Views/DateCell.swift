//
//  DateCell.swift
//  InfiniteCalendar
//
//  Created by Sunny on 2023/08/08.
//

import UIKit

final class DateCell: UICollectionViewCell {

    // MARK: Properties - View
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    // MARK: Lifecycle
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)

        configureHierarchy()
    }

    // MARK: Functions - Public
    func configure(with dayComponent: DayComponent) {

        numberLabel.text = dayComponent.number
    }

    // MARK: Functions - Private
    private func configureHierarchy() {

        contentView.addSubview(numberLabel)

        let topinset: CGFloat = 15

        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topinset),
            numberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
