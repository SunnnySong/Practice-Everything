//
//  Model.swift
//  Realm_practice
//
//  Created by 송선진 on 2022/10/31.
//

import UIKit
import RealmSwift

class Todo: Object {

    // RealmManager로 realm 과 관련된 활동들을 다 분리 -> delete, update를 할 때, id 를 사용하기 때문에 _id 대신 id 
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var status: Status = .onGoing
    
    // struct가 아닌 class이기 때문에 편의생성자 자동 제공 X
    convenience init(name: String, status: Status) {
        self.init()
        self.name = name
        self.status = status
    }
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
