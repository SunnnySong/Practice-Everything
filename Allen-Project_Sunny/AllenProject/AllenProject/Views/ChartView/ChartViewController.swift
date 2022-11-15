//
//  ChartViewController.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/15.
//

import UIKit
import Charts
import SnapKit

final class ChartViewController: UIViewController {
    
    let viewModel = ChartViewModel()
    
    private let chartView: BarChartView = {
        let chartView = BarChartView()
        
        // Hex color 사용할 수 있도록 UIColor에 extension함
        chartView.backgroundColor = UIColor(hex: "2B2C35")
        chartView.layer.cornerRadius = 20
        chartView.clipsToBounds = true
        
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChartView()
        setupChartData()
    }
    
    private func setupChartView() {
        view.addSubview(chartView)
        chartView.delegate = self
        
        chartView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
    }
    
    private func setupChartData() {
        chartView.data = viewModel.setBarChartData()
    }
    
}

extension ChartViewController: ChartViewDelegate {
}
