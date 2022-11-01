//
//  ViewController.swift
//  Realm_practice
//
//  Created by 송선진 on 2022/10/31.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    // MARK: - Properties
    var model = Todo()

    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupStatusBtn()
        setupUI()
    }

    // MARK: - Actions
    
    @IBAction func enterBtnTapped(_ sender: Any) {
        
        // Realm) realm -> 'Todo'의 object로 새로운 데이터 등록
        try! realm.write({
        realm.add(Todo(name: todoTextField.text ?? "nothing", status: .onGoing))
        })
        print(realm.objects(Todo.self))
        
        // 새로운 데이터 등록하면 tableView 다시 그리기
        tableView.reloadData()
        
        // textfield 초기화 하기
        todoTextField.text = ""
        enterButton.isEnabled = false
    }
    
    
    // MARK: - Helpers

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // row 간 구분선 제거
        tableView.separatorStyle = .none
    }
    
    
    private func setupStatusBtn() {
        statusButton.clipsToBounds = true
        statusButton.layer.cornerRadius = 30 / 2
        statusButton.backgroundColor = .red
        
        // pull-down-button
        let onGoing = UIAction(title: "진행중") { [weak self] _ in
            self?.statusButton.backgroundColor = .red
        }
        let completion = UIAction(title: "완료") { [weak self] _ in
            self?.statusButton.backgroundColor = .yellow
        }
        let buttonMenu = UIMenu(children: [onGoing, completion])
        statusButton.menu = buttonMenu
        
        /*
         showsMenuAsPrimaryAction, changesSelectionAsPrimaryAction 속성에 따라 pull-down 버튼 / pop-up 버튼 / 일반 버튼으로 나뉨.
         
         - changesSelectionAsPrimaryAction = true -> 짧게 클릭하면 버튼 토글, 버튼의 selection을 추적하게 됌(= menu 왼쪽에 v 표시 생김)
         - showsMenuAsPrimaryAction = false -> 길게 꾹 눌러야 menu 나옴, true는 짧게  클릭해도 바로 menu 나옴
         */
        statusButton.changesSelectionAsPrimaryAction = true
        statusButton.showsMenuAsPrimaryAction = true
        statusButton.tintColor = .clear
    }
    
    
    private func setupUI() {
        todoTextField.delegate = self
        
        // 처음 로드시 enter버튼 비활성화
        enterButton.isEnabled = false
        // textField에 글자 입력시, clear 버튼 자동 생성
        todoTextField.clearButtonMode = .whileEditing
        
    }

}


// UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    // cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return realm.objects(Todo.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TodoTableViewCell.self)", for: indexPath) as! TodoTableViewCell
        
        cell.cellStatusButton.clipsToBounds = true
        cell.cellStatusButton.layer.cornerRadius = 30 / 2
        
        // Realm) 'Todo'의 object들을 모두 로드
        let data = realm.objects(Todo.self)[indexPath.row]
        cell.cellTextField.text = data.name
        cell.cellStatusButton.backgroundColor = data.status.statusColor
        
        let onGoing = UIAction(title: "진행중") { _ in
            cell.cellStatusButton.backgroundColor = .red
            
            // Realm) object update
            try! self.realm.write({
                data.status = .onGoing
            })
        }
        let completion = UIAction(title: "완료") { _ in
            cell.cellStatusButton.backgroundColor = .yellow
            
            try! self.realm.write({
                data.status = .completion
            })
        }
        let buttonMenu = UIMenu(children: [onGoing, completion])
        cell.cellStatusButton.menu = buttonMenu
        
        // cell 선택시 회색 색깔 없애기
        cell.selectionStyle = .none
        
        return cell
    }
    
    // 참고: https://furang-note.tistory.com/30
    // UITableViewCell Swipe Delete 구현 : canEditRowAt, commit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            let data = realm.objects(Todo.self)[indexPath.row]
            try! realm.write({
                realm.delete(data)
            })
        }
        tableView.reloadData()
    }
}

// UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    // 스토리보드에서 stackView나 cellStatusButton의 높이를 지정하려 하니 오류가 남. cell의 rowHeight를 바꿔줘야함
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /*
         typealias NSRange = _NSRange

         public struct _NSRange {
           public var location: Int
           public var length: Int
         }
         
         -> textField에 글자를 한글자 입력하면 location 숫자가 올라가고, 한글자 삭제하면 length가 1이 된다. 이 상태에서 다시 글자를 입력하면 location숫자는 +1, length는 다시 0
         */
        if range.location == 0 && range.length != 0 {
            // 글자를 입력하지 않으면 버튼 비활성화
            self.enterButton.isEnabled = false
        } else {
            // 글자 입력시에만 enter버튼 활성화
            self.enterButton.isEnabled = true
        }
        return true
    }
}
