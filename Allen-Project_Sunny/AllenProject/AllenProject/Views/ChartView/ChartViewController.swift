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
enum Section {
    case goal
    case buy
    case win
}

enum GoalResult: String {
    case success = "달성 완료!"
    case fail = "달성 실패!"
    case percent
}

final class ChartViewController: UIViewController {
    
    struct Amount: Hashable {
        // 여기에 image, title 다 넣어서 만들어보기
        let id = UUID()
        var amount: Double
        var result: String
        var percent: Int
    }
    
    let viewModel = ChartViewModel()
    
    private let chartView: BarChartView = {
        let chartView = BarChartView()
        
        // chart와 BarChartView 간 bottom 간격 조정
//        chartView.setExtraOffsets(left: 20, top: 20, right: 20, bottom: 20)

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
        cv.backgroundColor = .white
        cv.rowHeight = 70
        return cv
    }()
    
    var dataSource: UITableViewDiffableDataSource<Section, Amount>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChartView()
        setupChartData()
        
        setupLottoListView()
        setupLottoListDataSource()
        setupLottoListSnapshot()
    }
    
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
        chartView.data = viewModel.setBarChartData()
    }
    
    private func setupLottoListView() {
        view.addSubview(lottoListView)
        
        // 구분선 제거
        lottoListView.separatorStyle = .none
        
        self.lottoListView.register(LottoListCell.self, forCellReuseIdentifier: "\(LottoListCell.self)")
        
        lottoListView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(240)
        }
    }
    
    private func setupLottoListDataSource() {
        self.dataSource = UITableViewDiffableDataSource(tableView: self.lottoListView) { (tableView, indexPath, item) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(LottoListCell.self)", for: indexPath) as! LottoListCell
            cell.amountLabel.text = String("\(Int(item.amount)) 원")
            
            if indexPath.section == 0 {
                cell.titleLabel.text = "목표 금액"
                cell.mainImage.image = UIImage(named: "medal")
                cell.sOrFLabel.text = item.result
            } else if indexPath.section == 1 {
                cell.titleLabel.text = "구매 금액"
                cell.mainImage.image = UIImage(named: "happy")
                cell.sOrFLabel.text = item.result
            } else {
                cell.titleLabel.text = "당첨 금액"
                cell.mainImage.image = UIImage(named: "trophy")
                // 마지막 cell에서는 구매금액 - 당첨금액 으로 % 내야하기 때문에 따로 설정
                cell.setupPercent(percent: item.percent)
            }
            
            return cell
            
        }
    }
    
    private func setupLottoListSnapshot() {
        let monthData = viewModel.getMonthList(month: 3.0)
        var result = GoalResult.percent
        let goalAmount = monthData.goalAmount
        let buyAmount = monthData.buyAmount
        let winAmount = monthData.winAmount
        let percent = ((winAmount - buyAmount) / buyAmount) * 100
        
        if Int(goalAmount) >= Int(buyAmount) {
            result = .success
        } else {
            result = .fail
        }
        
        let item1 = [Amount(amount: goalAmount, result: result.rawValue, percent: Int(percent))]
        let item2 = [Amount(amount: buyAmount, result: result.rawValue, percent: Int(percent))]
        let item3 = [Amount(amount: winAmount, result: result.rawValue, percent: Int(percent))]
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Amount>()
        
        snapshot.appendSections([.goal, .buy, .win])
        snapshot.appendItems(item1, toSection: .goal)
        snapshot.appendItems(item2, toSection: .buy)
        snapshot.appendItems(item3, toSection: .win)
        
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ChartViewController: ChartViewDelegate {
    
    // bar 클릭시 실행되는 함수
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
       print(entry)
    }
}
