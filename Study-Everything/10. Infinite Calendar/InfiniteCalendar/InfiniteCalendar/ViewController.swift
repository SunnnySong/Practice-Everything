//
//  ViewController.swift
//  InfiniteCalendar
//
//  Created by Sunny on 2023/08/08.
//

import UIKit

enum Section: Hashable {
    case pre
    case now
    case next
}

final class ViewController: UIViewController {

    private let totalCalendar: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(DateCollectionCell.self)
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    var dataSource: UICollectionViewDiffableDataSource<Section, [DayComponent]>!

//    private let calendar: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        collectionView.register(DateCell.self)
//        collectionView.isPagingEnabled = true
//        return collectionView
//    }()

//    private let calendar = CalendarView()

    private lazy var dateCalculator = DateCalculator(baseDate: baseDate)

    private var baseDate: Date = Date() {
        didSet {
            updateDays()
            totalCalendar.reloadData()
        }
    }
    private var days: [[DayComponent]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        days = dateCalculator.getDaysInMonth(for: baseDate)

        setupCalendarView()
        configureCalendarView()
        configureSnapshot()
        setupCenterXOffset()
    }

    private func setupCalendarView() {
        totalCalendar.frame = view.bounds
        view.addSubview(totalCalendar)
    }

    private func configureCalendarView() {
//        totalCalendar.dataSource = self
        totalCalendar.delegate = self

        dataSource = UICollectionViewDiffableDataSource<Section, [DayComponent]>(collectionView: self.totalCalendar) { collectionView, indexPath, item in

            let dateCollectionCell: DateCollectionCell = collectionView.dequeue(for: indexPath)
            dateCollectionCell.configure(with: item)
            return dateCollectionCell
        }
        totalCalendar.dataSource = dataSource
    }

    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, [DayComponent]>()
        snapshot.appendSections([.pre, .now, .next])
        snapshot.appendItems([days[0]], toSection: .pre)
        snapshot.appendItems([days[1]], toSection: .now)
        snapshot.appendItems([days[2]], toSection: .next)
        dataSource.apply(snapshot)
    }

    private func setupCenterXOffset() {
        // 가운데 섹션의 인덱스를 계산합니다.
        let middleSectionIndex = totalCalendar.numberOfSections / 2

        // 가운데 섹션의 x 좌표를 계산합니다.
        let middleSectionX = totalCalendar.collectionViewLayout.collectionViewContentSize.width / CGFloat(totalCalendar.numberOfSections) * CGFloat(middleSectionIndex)

        // collectionView의 content offset을 가운데 섹션의 위치로 설정합니다.
        totalCalendar.setContentOffset(CGPoint(x: middleSectionX, y: 0), animated: false)
    }

    private func updateDays() {
        days = dateCalculator.getDaysInMonth(for: baseDate)
    }
}

//extension ViewController: UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return days.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let dateCollectionCell: DateCollectionCell = collectionView.dequeue(for: indexPath)
//        dateCollectionCell.configure(with: days, section: indexPath.section)
//
//        return dateCollectionCell
//    }
//}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = collectionView.bounds.width
        let cellHeight = collectionView.bounds.height

        return CGSize(width: cellWidth, height: cellHeight)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let standardOffset = totalCalendar.frame.width

        if standardOffset > scrollView.contentOffset.x {
            let calendar = Calendar(identifier: .gregorian)
            baseDate = calendar.date(byAdding: .month, value: -1, to: baseDate) ?? .now
        } else {
        }

    }
}

