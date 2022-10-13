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
class ViewController: UIViewController {

    private lazy var chartView: BarChartView = {
        let chartView = BarChartView()
        chartView.backgroundColor = UIColor(hex: "#FFDDA6").withAlphaComponent(0.3)
        chartView.layer.cornerRadius = 20
        chartView.clipsToBounds = true
        // chart와 BarChartView 간 bottom 간격 조정
        chartView.extraBottomOffset = 15
        // 차트 확대
//        chartView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        // 차트 더블클릭하면 무한 확대되는것 false
        chartView.setScaleEnabled(false)
        // 바 별 뭘 의미하는지 알려주는 것
        chartView.legend.enabled = false
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barChartLayout()
        settingData()
        barChartConfiguration()
        
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
        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        // 1월부터 12월까지 표시
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: MoneyData.monthLabel)
        chartView.xAxis.setLabelCount(12, force: false)
        chartView.xAxis.labelPosition = .bottom
    }

    func barChartLayout() {
        view.addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
    }
    
    func settingData() {
        let dataManager = DataManager()
        chartView.data = dataManager.setChartData()
    }
    
}


extension ViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print(entry)
    }
}
