//
//  ViewController.swift
//  FSCalendar_practice
//
//  Created by 송선진 on 2022/10/17.
//

import UIKit
import FSCalendar
import SnapKit

class ViewController: UIViewController {

    let calendar = CalendarView()
    
    let lottoListdataManager = DataManager()
    let lottoListCell = LottoTableViewCell()
    
    let lottoTableView: UITableView = {
        let tableView = UITableView()
        // tableViewCell 등록
        tableView.register(LottoTableViewCell.self, forCellReuseIdentifier: "\(LottoTableViewCell.self)")
        // tableView에 하나의 item이 속해있는 row 높이 설정
        tableView.rowHeight = 86
        return tableView
    }()
    
    var selectedDate: Date? = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendar()
        setupTableView()
    }
    
    // MARK: - Helpers

    private func setupTableView() {
        lottoTableView.dataSource  = self
        lottoTableView.delegate = self
        
        view.addSubview(lottoTableView)
        lottoTableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
        
        // row 구분선 제거
        lottoTableView.separatorStyle = .none
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

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return lottoListdataManager.findSelectedData(selectedDate: selectedDate).count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell 등록
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LottoTableViewCell.self)", for: indexPath) as! LottoTableViewCell
        // selectedDate와 날짜가 동일한 lottoData를 불러오기
        let lottoArray = lottoListdataManager.findSelectedData(selectedDate: selectedDate)[indexPath.row]
        
        // cell의 속성과 실제 데이터 연동
        cell.dateLabel.text = lottoArray.buyDate
        cell.lottoTypeLabel.text = lottoArray.lottoType.rawValue
        cell.lottoAmountLabel.text = String(lottoArray.lottoAmount)
        
        print(#function)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}


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
        
        // ***** selectedDate에 맞는 lottoTableView를 다시 로드
        // lottoTableView 다시 로드하면 tableView(_:cellForRowAt:), tableView(_:numberOfRowsInSection:) 등 모두 다시 로드
        self.lottoTableView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
//        print(dateFormatter.string(from: date) + " 날짜 선택 완료")
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

// HEX color
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
