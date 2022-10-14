//
//  ViewController.swift
//  Chart
//
//  Created by 송선진 on 2022/10/11.
//

import UIKit
import Charts
import SnapKit

// 자세한 설명: https://www.youtube.com/watch?v=csd7pyfEXgw

// bar 모서리 라운드 처리 : https://wlxo0401.oopy.io/8082412e-80e9-4f79-b2a1-164a9036fc6f


class ViewController: UIViewController {
    
    private let dataManager = DataManager()
    private let customMarkerView = CustomMarkerView()
    
    private var label: UILabel = {
        let la = UILabel()
        la.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        la.textColor = .red
        la.text = "과연 얼마를 날렸을까요?"
        return la
    }()
    
    private lazy var chartView: BarChartView = {
        let chartView = BarChartView()
        chartView.delegate = self
        
        chartView.backgroundColor = UIColor(hex: "#FFDDA6").withAlphaComponent(0.3)
        chartView.layer.cornerRadius = 20
        chartView.clipsToBounds = true
        
        // chart와 BarChartView 간 bottom 간격 조정
        chartView.extraBottomOffset = 20
        chartView.extraLeftOffset = 20
        chartView.extraRightOffset = 20
        chartView.extraTopOffset = 20
    
        // 차트 확대
//        chartView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        // 차트 더블클릭하면 무한 확대되는것 false
        chartView.setScaleEnabled(false)
        // 바 별 뭘 의미하는지 알려주는 것
        chartView.legend.enabled = false
        
        // https://medium.com/geekculture/swift-ios-charts-tutorial-highlight-selected-value-with-a-custom-marker-30ccbf92aa1b
//        chartView.data?.isHighlightEnabled = true
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barChartLayout()
        settingData()
        barChartConfiguration()
        
        setMarker()
    }
    
    func setMarker() {
        customMarkerView.chartView = chartView
        chartView.marker = customMarkerView
    }
    
    func barChartConfiguration() {
        // 오른쪽 금액 표시 비활성화
        chartView.rightAxis.enabled = false
        
        // ZeroLine : y=0 선
        chartView.leftAxis.enabled = false
//        chartView.leftAxis.drawZeroLineEnabled = true
//        chartView.leftAxis.zeroLineWidth = 3
//        chartView.leftAxis.labelCount = 3
//        chartView.leftAxis.labelTextColor = .red
        
        chartView.xAxis.labelTextColor = .black
        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 11, weight: .bold)
        
        // 1월부터 12월까지 표시
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: MoneyData.monthLabel)
        chartView.xAxis.setLabelCount(12, force: false)
        chartView.xAxis.labelPosition = .bottom
        // bar 별 xAxis 세로선 삭제하기
        chartView.xAxis.drawGridLinesEnabled = false
    }

    func barChartLayout() {
        view.addSubview(chartView)
        view.addSubview(label)
        
        chartView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func settingData() {
        chartView.data = dataManager.setChartData()
    }
    
}


extension ViewController: ChartViewDelegate {
    
    // bar 클릭시 실행되는 함수
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        customMarkerView.moneyLabel.text = "\(Int(entry.y)) 원"
        label.text = "\(Int(entry.y)) 원"
    }
}
