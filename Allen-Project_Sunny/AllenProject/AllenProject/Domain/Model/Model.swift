//
//  LottoHistory.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/15.
//

import Foundation

// 서버에서 받아오는 데이터 타입.. 이지만 일단 사용하기 쉬운 데이터 타입으로 임의 설정
struct LottoItem {
    var buyMonth: Double    // BarChartDataEntry에 넣기 편리하도록 Double 타입 선언
    var buyAmount: Double
    var winAmount: Double
    
    static var rowData: [LottoItem] = [
        LottoItem(buyMonth: 1, buyAmount: 5000, winAmount: 0),
        LottoItem(buyMonth: 2, buyAmount: 55000, winAmount: 50000),
        LottoItem(buyMonth: 3, buyAmount: 35000, winAmount: 100000),
        LottoItem(buyMonth: 4, buyAmount: 25000, winAmount: 5000),
        LottoItem(buyMonth: 5, buyAmount: 1000, winAmount: 3000),
        LottoItem(buyMonth: 6, buyAmount: 5000, winAmount: 0),
        LottoItem(buyMonth: 7, buyAmount: 10000, winAmount: 2000),
        LottoItem(buyMonth: 8, buyAmount: 100000, winAmount: 1000),
        LottoItem(buyMonth: 9, buyAmount: 15000, winAmount: 5000),
        LottoItem(buyMonth: 10, buyAmount: 170000, winAmount: 100000),
        LottoItem(buyMonth: 11, buyAmount: 35000, winAmount: 6000),
        LottoItem(buyMonth: 12, buyAmount: 82000, winAmount: 2000)
    ]
}
