//
//  ViewController.swift
//  Chart
//
//  Created by 송선진 on 2022/10/11.
//

import UIKit
import Charts
import SnapKit

class ViewController: UIViewController {

    private lazy var barChartView: BarChartView = {
        let chartView = BarChartView()
        chartView.backgroundColor = UIColor(hex: "#FFDDA6").withAlphaComponent(0.3)
        // 오른쪽 금액 표시 비활성화
        chartView.rightAxis.enabled = false
        chartView.leftAxis.labelTextColor = .black
        
        chartView.xAxis.labelTextColor = .black
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        // 1월부터 12월까지 표시
        chartView.xAxis.setLabelCount(12, force: false)
        
        chartView.leftAxis.drawZeroLineEnabled = true
        chartView.leftAxis.zeroLineWidth = 3

        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barChartConfiguration()
        settingData()
    }

    func barChartConfiguration() {
        view.addSubview(barChartView)
        
        barChartView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
    }
    
    func settingData() {
        let dataManager = DataManager()
        barChartView.data = dataManager.formatDataSet()
    }
    
}


extension ViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print(entry)
    }
}
