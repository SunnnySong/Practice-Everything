//
//  ChartViewController.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/15.
//

import UIKit
import Charts
import SnapKit

// bar 모서리 라운드 처리 : https://wlxo0401.oopy.io/8082412e-80e9-4f79-b2a1-164a9036fc6f

// dataSource 관련 참조: 보고 코드 정리하기. https://www.hackingwithswift.com/forums/ios/uitableview-diffable-data-source-section-headers-putting-data-source-outside-viewcontroller/2125

// TODO: 오늘 년도에 맞게, 선택된 연도에 맞게 chart 로드 다시하기

final class ChartViewController: UIViewController {
    
    // MARK: - Propertises
    
    let chartViewModel = ChartViewModel()
    let lottoListViewModel = LottoListViewModel()
    
    private let chartView: BarChartView = {
        let chartView = BarChartView()
    
        // Hex color 사용할 수 있도록 UIColor에 extension함
        chartView.backgroundColor = UIColor(hex: "2B2C35")
        chartView.layer.cornerRadius = 20
        chartView.clipsToBounds = true
        
        // chart 더블클릭시 확대되는 것 false
        chartView.setScaleEnabled(false)
        chartView.doubleTapToZoomEnabled = false
//        chartView.zoom(scaleX: 0.5, scaleY: 1, x: 0, y: 0)
        // chart bar 별 의미 적힌 동그라미 false
        chartView.legend.enabled = false
        return chartView
    }()
    
    private let lottoListView: UITableView = {
        let cv = UITableView(frame: .zero)
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        cv.rowHeight = 70
        return cv
    }()
    
    // TODO: typealias 공부하기
    typealias Section = LottoListDataSourceController.Section
    typealias Amount = LottoListDataSourceController.Amount
    
    var dataSource: UITableViewDiffableDataSource<Section, Amount>!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChartView()
        setupChartData()
        
        setupLottoListView()
        setupLottoListDataSource()
        setupLottoListSnapshot()
        
        setupDatePicker()
    }
    
    // MARK: - Helpers

    private func setupChartView() {
        view.addSubview(chartView)
        chartView.delegate = self
        
        chartView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(280)
        }
        
        // 오른쪽, 왼쪽 금액 표시 비활성화
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        
        // xAxis label 비활성화
        chartView.xAxis.drawLabelsEnabled = false
        // xAxis 선 비활성화
        chartView.xAxis.drawAxisLineEnabled = false
        // bar 별 xAxis 세로선 삭제하기
        chartView.xAxis.drawGridLinesEnabled = false
    }
    
    private func setupChartData() {
        chartView.data = chartViewModel.setBarChartData()
    }
    
    private func setupLottoListView() {
        view.addSubview(lottoListView)
        lottoListView.backgroundColor = .green
        
        // 구분선 제거
        lottoListView.separatorStyle = .none
        
        self.lottoListView.register(LottoListCell.self, forCellReuseIdentifier: "\(LottoListCell.self)")
        
        lottoListView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(380)
        }
    
        // delegate로 설정한 header은 tableView의 section마다 달리는 header. 이것은 전체 tableView의 header
        let header = LottoListHeader(frame: .init(x: 0, y: 0, width: lottoListView.frame.size.width, height: 30))
        header.dateTextField.delegate = self
        lottoListView.tableHeaderView = header
    }
    
    private func setupLottoListDataSource() {
        self.dataSource = UITableViewDiffableDataSource(tableView: self.lottoListView) { (tableView, indexPath, item) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(LottoListCell.self)", for: indexPath) as! LottoListCell
            
            cell.amountLabel.text = String("\(Int(item.amount)) 원")
            cell.sOrFLabel.text = item.result.title
            cell.sOrFLabel.textColor = item.result.textColor
            cell.setupCell(section: indexPath.section, percent: item.percent)
            return cell
        }
        
    }
    
    private func setupLottoListSnapshot() {
        guard let month = Double(lottoListViewModel.getTodayDate()[1]) else { return }
        
        let data = lottoListViewModel.getMonthList(month: month)
        guard let percentData = lottoListViewModel.getMonthPercent(month: month).first else { return }
        
        let item1 = [Amount(amount: data.goalAmount, result: percentData.key, percent: percentData.value)]
        let item2 = [Amount(amount: data.buyAmount, result: percentData.key, percent: percentData.value)]
        let item3 = [Amount(amount: data.winAmount, result: percentData.key, percent: percentData.value)]
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Amount>()
        
        snapshot.appendSections([.goal, .buy, .win])
        snapshot.appendItems(item1, toSection: .goal)
        snapshot.appendItems(item2, toSection: .buy)
        snapshot.appendItems(item3, toSection: .win)
        
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func setupDatePicker() {
//        view.addSubview(datePickerView)
        
//        datePickerView.dataSource = self
    }
}


// MARK: - Extension

// ChartViewDelegate
extension ChartViewController: ChartViewDelegate {
    
    // bar 클릭시 실행되는 함수
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
       print(entry)
    }
}

// DatePickerDelegate
extension ChartViewController: DatePickerViewDelegate {
    func didSelectedDate() {
        print("ChartViewController) didSelectedDate")
        
    }
}

// UITextFieldDelegate
extension ChartViewController: UITextFieldDelegate {
    
    // LottoListHeader의 dateTextField 수정 불가능하게 설정
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
