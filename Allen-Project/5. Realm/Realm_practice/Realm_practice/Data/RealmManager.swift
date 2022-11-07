//
//  RealmManager.swift
//  Realm_practice
//
//  Created by 송선진 on 2022/11/05.
//

import Foundation
import RealmSwift

class RealmManager {
    
    let realm = try! Realm()
    
    init() {
    }
    
    // Realm) realm -> 'Todo'의 object로 새로운 데이터 등록
    func addTodo(name: String) {
        do {
            try realm.write({
                let newTask = Todo(name: name, status: .onGoing)
                realm.add(newTask)
                print(realm.objects(Todo.self))
            })
        } catch {
            print("Error: adding task to Realm: \(error)")
        }
    }
    
    // 모든 todo를 가져오고, 정렬하는 함수. 하지만 실제 realm data는 그대로 유지. 
    func getTodos() -> Results<Todo> {
        let loadData = realm.objects(Todo.self)
        return loadData.sorted(byKeyPath: "status", ascending: false)
    }
    
    func deleteTodo(id: ObjectId) {
        do {
            // NSPredicate: 메모리 내에서 어떤 값을 가져올 때 filter 조건. 정규식 이용해서 판별.
            // 참고: https://ios-development.tistory.com/592
            let data = realm.objects(Todo.self).filter(NSPredicate(format: "id == %@", id))
            
            try realm.write({
                realm.delete(data)
            })
        } catch {
            print("Error: deleting task to Realm: \(error)")
        }
    }
    
    func updateTodo(id: ObjectId, name: String, status: Status) {
        do {
            let data = realm.objects(Todo.self).filter(NSPredicate(format: "id == %@", id))
            
            try realm.write({
                data[0].name = name
                data[0].status = status
            })
        } catch {
            print("Error: updating task to Realm: \(error)")
        }
    }
    
    func switchStatus(status: Status, data: Todo) {
        do {
            if status == .onGoing {
                try realm.write({
                    data.status = .onGoing
                })
            } else {
                try realm.write({
                    data.status = .completion
                })
            }
        } catch {
            print("Error: updating task to Realm: \(error)")
        }
    }
    
    // Realm Migration : https://jerry-bakery.tistory.com/entry/iOS-iOS-Realm-Migration마이그레이션-하는법
}
