//
//  ViewController.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/14.
//

import UIKit
import Charts
import SnapKit

final class ViewController: UIViewController {
    
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
}

extension ViewController: ChartViewDelegate {
}

