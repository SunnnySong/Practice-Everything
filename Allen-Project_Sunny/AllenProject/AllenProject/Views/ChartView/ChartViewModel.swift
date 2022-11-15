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
    private func setBarChartDataEntry(completion: ([BarChartDataSet]) -> [BarChartDataSet]) -> [BarChartDataSet] {
        let rowData = LottoItem.rowData
        // rowData를 BarChartDataEntry(x:,y:)로 변환
        let dataEntry = rowData.map { BarChartDataEntry(x: $0.buyMonth, y: ($0.buyAmount - $0.winAmount))
        }
        // BarChartDataEntry를 BarChartDataSet으로 변환하기 위해 completion으로 넘김.
        let dataSet = completion(setBarChartDataSet(dataEntry: dataEntry, completion: {$0}))
        
        return dataSet
    }
    
    // 2. BarChartDataSet 변환하기
    // BarChartDataSet을 구지 두개로 나눈 이유는 마이너스와 플러스 바 별 색상 변화를 주고 싶었기 때문.
    private func setBarChartDataSet(dataEntry: [BarChartDataEntry], completion: ([BarChartDataSet]) -> [BarChartDataSet]) -> [BarChartDataSet] {
        
        let minus = dataEntry.filter { $0.y < 0 }
        let plus = dataEntry.filter { $0.y > 0 }
        
        let minusSet = BarChartDataSet(entries: minus)
        let plusSet = BarChartDataSet(entries: plus)
        
        return completion(configureDataSet(minusSet: minusSet, plusSet: plusSet))
    }
    
    // 2-1. BarChartDataSet 관련 설정 변경하기
    private func configureDataSet(minusSet: BarChartDataSet, plusSet: BarChartDataSet) -> [BarChartDataSet] {
        
        // 마이너스면 파란색바, 플러스면 주황색바
        minusSet.colors = [ NSUIColor(hex: "#4880EE") ]
        plusSet.colors = [ NSUIColor(hex: "#EC6E59") ]
        
        // bar 위 숫자 설정
        minusSet.drawValuesEnabled = false
        plusSet.drawValuesEnabled = false
        
        return [ minusSet, plusSet ]
    }
    
    // 3. BarChartData 변환하기
    func setBarChartData() -> BarChartData {
        
        let chartData = setBarChartDataEntry { $0 }
        let data = BarChartData(dataSets: chartData)
        
        return data
    }
    
}


