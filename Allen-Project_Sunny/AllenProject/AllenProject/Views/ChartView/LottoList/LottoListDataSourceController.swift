//
//  LottoListDataSourceController.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/27.
//

import UIKit

class LottoListDataSourceController {
    enum Section {
        case goal, buy, win
        
        var title: String {
            switch self {
            case .goal:
                return "목표 금액"
            case .buy:
                return "구매 금액"
            case .win:
                return "당첨 금액"
            }
        }
        
        var image: UIImage {
            switch self {
            case .goal:
                return UIImage(named: "medal")!
            case .buy:
                return UIImage(named: "happy")!
            case .win:
                return UIImage(named: "trophy")!
            }
        }
    }
    
    enum GoalResult {
        case success
        case fail
        case percent
        
        var title: String {
            switch self {
            case .success:
                return "달성 완료!"
            case .fail:
                return "달성 실패!"
            case .percent:
                return ""
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .success:
                return UIColor.green
            case .fail:
                return UIColor.red
            case .percent:
                return UIColor.clear
            }
        }
    }
    
    struct Amount: Hashable {
        // 여기에 image, title 다 넣어서 만들어보기
        let id = UUID()
        var amount: Double?
        var result: GoalResult?
        var percent: Int?
    }
}
