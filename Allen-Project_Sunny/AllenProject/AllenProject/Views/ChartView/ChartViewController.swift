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
        
        // zero line 활성화
//        chartView.leftAxis.enabled = true
//        chartView.leftAxis.drawAxisLineEnabled = false
//        chartView.leftAxis.drawLabelsEnabled = false
//        chartView.leftAxis.drawGridLinesEnabled = false
//        chartView.leftAxis.zeroLineWidth = 5
//        chartView.leftAxis.zeroLineColor = .yellow
//        chartView.leftAxis.drawZeroLineEnabled = true
        
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
        // custom한 markerView의 chart를 해당 chartView로 설정
        chartMarkerView.chartView = chartView
        // chart의 marker을 custom한 markerView로 설정
        chartView.marker = chartMarkerView
    }
    
}

extension ChartViewController: ChartViewDelegate {
    
    // bar 클릭시 실행되는 함수
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        let barHeight = self.chartView.getBarBounds(entry: entry as! BarChartDataEntry).height
        let barY = self.chartView.getBarBounds(entry: entry as! BarChartDataEntry).minY
        let barX = self.chartView.getBarBounds(entry: entry as! BarChartDataEntry).minX
        
        let markerWidth = chartMarkerView.baseView.frame.width
        let markerHeight = chartMarkerView.baseView.frame.height
        
        let sidePadding = CGFloat(8)
        let a = chartView.frame.width - sidePadding - barX
        let b = markerWidth / 2 + sidePadding
        
        // +바이면 marker가 위쪽에 위치
        if highlight.y > 0 {
            // marker가 chartView를 벗어나는것을 방지.
            if barY - (markerWidth/2 + sidePadding) < 0 {
                chartMarkerView.offset = .init(x: -( markerWidth / 2), y: -(barY-sidePadding))
            } else {
                chartMarkerView.offset = .init(x: -( markerWidth / 2), y: -( markerHeight + sidePadding))
            }
        } else {
            // -바이면 marker가 아래쪽에 위치
            // marker가 chartView를 벗어나는것을 방지.
            if barY + barHeight + (markerWidth/2 + sidePadding) >= chartView.frame.height - sidePadding {
                chartMarkerView.offset = .init(x: -(markerWidth / 2), y: chartView.frame.height-barY-(markerWidth/2 + sidePadding))
            } else {
                chartMarkerView.offset = .init(x: -(markerWidth / 2), y: barHeight + sidePadding)
            }
        }
        
        // 양 옆 사이드 marker 벗어나는것 방지
        if barX - b < 0 {
            chartMarkerView.offset.x = .init(-barX)
        } else if a < b {
            chartMarkerView.offset.x = .init(-(markerWidth / 2 + b - a + sidePadding))
        }

    }
}
