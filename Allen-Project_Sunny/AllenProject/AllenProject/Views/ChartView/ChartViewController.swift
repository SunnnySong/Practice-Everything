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

final class ChartViewController: UIViewController {
    
    let viewModel = ChartViewModel()
    let chartMarkerView = ChartMarkerView()
    
    private let chartView: BarChartView = {
        let chartView = BarChartView()
        
        // Hex color 사용할 수 있도록 UIColor에 extension함
        chartView.backgroundColor = UIColor(hex: "2B2C35")
        chartView.layer.cornerRadius = 20
        chartView.clipsToBounds = true
        
        // chart 더블클릭시 확대되는 것 false
        chartView.setScaleEnabled(false)
        // chart bar 별 의미 적힌 동그라미 false
        chartView.legend.enabled = false
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChartView()
        setupChartData()
        setupChartMarkerView()
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
        
        // 1~12 월 표시
//        chartView.xAxis.labelTextColor = .white
//        chartView.xAxis.labelPosition = .bottom
//        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 11, weight: .bold)
        // xAsxis의 값을 index로 표현
//        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: viewModel.monthLabel)
//        chartView.xAxis.setLabelCount(12, force: false)
    }
    
    private func setupChartData() {
        chartView.data = viewModel.setBarChartData()
    }
    
    private func setupChartMarkerView() {
        chartMarkerView.chartView = chartView
        chartView.marker = chartMarkerView
    }
    
}

extension ChartViewController: ChartViewDelegate {
    
    // bar 클릭시 실행되는 함수
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print(entry)
        chartMarkerView.monthLabel.text = "\(Int(entry.x)) 월"
        chartMarkerView.moneyLabel.text = "\(Int(entry.y)) 원"
        
        print(chartMarkerView.offset)
        if entry.x == 12.0 {
//            chartMarkerView.offset = .init(x: -(baseView.frame.width / 2 + 40), y: -(baseView.frame.height + 3))
        }
    }
}
