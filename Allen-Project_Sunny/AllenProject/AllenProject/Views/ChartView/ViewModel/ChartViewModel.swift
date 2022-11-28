//
//  ChartViewModel.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/15.
//

import UIKit
import Charts

class ChartViewModel {
    
    // 1. BarChartDataEntry 변환하기.
    // BarChartDataEntry의 x, y는 모두 Double 타입
    private func setBarChartDataEntry(completion: (BarChartDataSet) -> BarChartDataSet) -> BarChartDataSet {
        let rowData = LottoItem.rowData
        // rowData를 BarChartDataEntry(x:,y:)로 변환
        let dataEntry = rowData.map { BarChartDataEntry(x: $0.buyMonth, y: $0.winAmount - $0.buyAmount)
        }
        // BarChartDataEntry를 BarChartDataSet으로 변환하기 위해 completion으로 넘김.
        let dataSet = completion(setBarChartDataSet(dataEntry: dataEntry, completion: {$0}))
        
        return dataSet
    }
    
    // 2. BarChartDataSet 변환하기
    private func setBarChartDataSet(dataEntry: [BarChartDataEntry], completion: (BarChartDataSet) -> BarChartDataSet) -> BarChartDataSet {
        
        let dataSet = BarChartDataSet(entries: dataEntry)
        dataSet.colors = [ NSUIColor(hex: "#4880EE") ]
        // bar 위 숫자 설정
        dataSet.drawValuesEnabled = false
        
        return dataSet
    }
    
    // 3. BarChartData 변환하기
    func setBarChartData() -> BarChartData {
        
        let chartData = setBarChartDataEntry { $0 }
        let data = BarChartData(dataSet: chartData)
        
        return data
    }
}


