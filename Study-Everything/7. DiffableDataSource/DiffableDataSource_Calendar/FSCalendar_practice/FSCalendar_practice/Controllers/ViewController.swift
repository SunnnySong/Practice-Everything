//
//  ViewController.swift
//  FSCalendar_practice
//
//  Created by 송선진 on 2022/10/17.
//

import UIKit
import FSCalendar
import SnapKit

// tableView diffableDataSource 참조 :  https://rldd.tistory.com/493
class ViewController: UIViewController {

    var dataSource: UITableViewDiffableDataSource<Section, LottoData>!
    
    let calendar = CalendarView()
    
    let lottoListdataManager = DataManager()
    
    let lottoTableView: UITableView = {
        let tableView = UITableView()
        // tableView에 하나의 item이 속해있는 row 높이 설정
        tableView.rowHeight = 86
        return tableView
    }()
    
    var selectedDate: Date? = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendar()
        setupTableView()
        setupTableViewDataSource()
        setupTableViewSnapshot()
    }
    
    // MARK: - Helpers

    private func setupTableView() {
        view.addSubview(lottoTableView)
        
        self.lottoTableView.register(LottoTableViewCell.self, forCellReuseIdentifier: "\(LottoTableViewCell.self)")
        
        lottoTableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
        
        // row 구분선 제거
        lottoTableView.separatorStyle = .none
    }
    
    private func setupTableViewDataSource() {

        self.dataSource = UITableViewDiffableDataSource<Section, LottoData>(tableView: self.lottoTableView) { (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(LottoTableViewCell.self)", for: indexPath) as! LottoTableViewCell

            cell.dateLabel.text = itemIdentifier.buyDate
            cell.lottoTypeLabel.text = itemIdentifier.lottoType.rawValue
            cell.lottoAmountLabel.text = String(itemIdentifier.lottoAmount)
            return cell
        }
    }
    
    private func setupTableViewSnapshot() {
        let lottoArray = lottoListdataManager.findSelectedData(selectedDate: selectedDate)
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, LottoData>()
        snapshot.appendSections([.lottoView])
        snapshot.appendItems(lottoArray)
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func setupCalendar() {
        calendar.dataSource = self
        calendar.delegate = self
        
        view.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(330)
        }
    }
}


// MARK: - Extensions

// FSCalendarDelegate
extension ViewController: FSCalendarDelegate {
    // Calendar 주간, 월간 원활한 크기 변화를 위해
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 날짜 클릭시, selectedDate를 해당 날짜로 설정
        self.selectedDate = date
        
        self.setupTableViewSnapshot()
    }
}

// FSCalendarDataSource
extension ViewController: FSCalendarDataSource {
    
    // event가 있다면 글자 밑에 표시하기
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let eventsArray = DataManager.changeStringToDate()
        let dateArray = eventsArray.map { $0.buyDate }
        if dateArray.contains(date) {
            return 1
        }
        return 0
    }
}

enum Section {
    case lottoView
}
