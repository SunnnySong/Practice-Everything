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
        chartView.backgroundColor = .systemPink
        chartView.
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
        barChartView.data = dataManager.setData()
    }
    
}


extension ViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print(entry)
    }
}
