//
//  LottoData.swift
//  FSCalendar_practice
//
//  Created by 송선진 on 2022/10/19.
//

import UIKit

enum LottoType: String {
    case lotto = "로또"
    case instantLotto = "스피또"
}

/* struct가 아닌, class로 Hashable을 만들 경우
 class LottoData2 {
     
     let uuid: UUID = UUID()
     var buyDate: String = ""
     var lottoType: LottoType
     var lottoAmount: Int = 0
     
     init(date: String, type: LottoType, amount: Int) {
         self.buyDate = date
         self.lottoType = type
         self.lottoAmount = amount
     }
 }

 extension LottoData2: Hashable {
     static func == (lhs: LottoData2, rhs: LottoData2) -> Bool {
         return lhs.buyDate == rhs.buyDate && lhs.lottoType == rhs.lottoType && lhs.lottoAmount == rhs.lottoAmount
     }
     
     func hash(into hasher: inout Hasher) {
         hasher.combine(buyDate)
         hasher.combine(lottoType)
         hasher.combine(lottoAmount)
     }
 } 
 */

struct LottoData: Hashable {
    let uuid: UUID = UUID()
    var buyDate: String
    var lottoType: LottoType
    var lottoAmount: Int
    
    static var rowData: [LottoData] = [
        
        LottoData(buyDate: "2022-11-19", lottoType: .lotto, lottoAmount: 5000),
        LottoData(buyDate: "2022-11-24", lottoType: .lotto, lottoAmount: 5000),
        LottoData(buyDate: "2022-11-23", lottoType: .lotto, lottoAmount: 5000),
        LottoData(buyDate: "2022-11-11", lottoType: .lotto, lottoAmount: 5000),
        LottoData(buyDate: "2022-11-21", lottoType: .lotto, lottoAmount: 5000),
        LottoData(buyDate: "2022-11-24", lottoType: .lotto, lottoAmount: 10000),
        LottoData(buyDate: "2022-11-11", lottoType: .lotto, lottoAmount: 10000),
        LottoData(buyDate: "2022-11-21", lottoType: .lotto, lottoAmount: 10000)
    ]
}


// HEX color
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
