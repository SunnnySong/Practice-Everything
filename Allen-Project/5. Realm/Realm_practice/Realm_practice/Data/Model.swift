//
//  Model.swift
//  Realm_practice
//
//  Created by 송선진 on 2022/10/31.
//

import UIKit
import RealmSwift

class Todo: Object {
    
//    var name: String = ""
//    var status: Status = .onGoing
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var status: Status = .onGoing
//
//    // struct가 아닌 class이기 때문에 편의생성자 자동 제공 X
    convenience init(name: String, status: Status) {
        self.init()
        self.name = name
        self.status = status
    }
    
    static var rowData: [Todo] = [
        Todo(name: "빨래하기", status: .onGoing),
        Todo(name: "청소하기", status: .completion)
    ]
}

// toDo 진행 상황 enum
// Realm에서 enum 사용하기 위해 PersistableEnum 프로토콜 채택
enum Status: String, PersistableEnum {
    case onGoing
    case completion
}

// 진행 상황에 따른 UIColor
extension Status {
    var statusColor: UIColor {
        get {
            switch self {
            case .onGoing :
                return UIColor.red
            case .completion :
                return UIColor.yellow
            }
        }
    }
}
