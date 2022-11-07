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
 
    let realmManager = RealmManager()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupStatusBtn()
        setupUI()
    }

    // MARK: - Actions
    
    @IBAction func enterBtnTapped(_ sender: Any) {
        
        guard let text = todoTextField.text else { return }
        realmManager.addTodo(name: text)
        
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
        
        return realmManager.getTodos().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TodoTableViewCell.self)", for: indexPath) as! TodoTableViewCell
        
        // Realm) 'Todo'의 object들을 모두 로드
        let data = realmManager.getTodos()[indexPath.row]
        cell.cellTextField.text = data.name
        cell.cellStatusButton.backgroundColor = data.status.statusColor
        
        let onGoing = UIAction(title: "진행중") { _ in
            cell.cellStatusButton.backgroundColor = .red
            // Realm) object update
            self.realmManager.switchStatus(status: .onGoing, data: data)
            tableView.reloadData()
        }
        let completion = UIAction(title: "완료") { _ in
            cell.cellStatusButton.backgroundColor = .yellow
            self.realmManager.switchStatus(status: .completion, data: data)
            tableView.reloadData()
        }
        let buttonMenu = UIMenu(children: [onGoing, completion])
        cell.cellStatusButton.menu = buttonMenu
        
        cell.cellTextField.delegate = self
        // func textFieldDidEndEditing(_ textField: UITextField)는 IndexPath.row가 없기 때문에 textField가 눌러진 해당 todo를 realmManager에다가 전달해줘야 하는데 어려움이 생김. 그래서 cellTextField.tag에 indexPath.row를 전달해주고 textFieldDidEndEditing 함수에서 IndexPath.row대신 사용하기로 함.
        // cell의 첫번째 textfield.tag도 0이고, todoTextfield.tag 도 0 이기 때문에 + 1.
        cell.cellTextField.tag = indexPath.row + 1
        
        return cell
    }
    
    // 참고: https://furang-note.tistory.com/30
    // UITableViewCell Swipe Delete 구현 : canEditRowAt, commit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            let data = realmManager.getTodos()[indexPath.row].id
            realmManager.deleteTodo(id: data)
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
    
    // 원래, 아래 코드를 구현하여 cell안의 textField를 클릭하면 해당 코드가 실행되면서 realmManager.updateTodo()를 실행시키려 했음. 하지만 아래 코드는 textField 외의 여백을 눌렀을 때 실행됌. 그러므로 cell안의 textField를 수정해도 아래 코드가 작동되지 않아 update 불가.
    // 해결) func textFieldDidEndEditing(_ textField: UITextField) 이용
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
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
        if textField == todoTextField {
            if range.location == 0 && range.length != 0 {
                // 글자를 입력하지 않으면 버튼 비활성화
                self.enterButton.isEnabled = false
            } else {
                // 글자 입력시에만 enter버튼 활성화
                self.enterButton.isEnabled = true
            }
        }
        return true
    }
    
    // textField를 벗어나게 되면 실행되는 함수. textField를 벗어나면 자동으로 updateTodo()실행.
    // 여기서 updateTodo()에 textField가 클릭된 todo를 지정해서 전달해줘야 하기 때문에, tag를 indexPath.row처럼 사용
    // textField.tag == 0인 todoTextField를 제외하고 updateTodo() 실행
    func textFieldDidEndEditing(_ textField: UITextField) {
   
        if textField.tag > 0 {
            let index = textField.tag - 1
            let data = realmManager.getTodos()[index]
            guard let text = textField.text else { return }
            realmManager.updateTodo(id: data.id, name: text)
        }
    }
    
    // 키보드 return 시 키보드 내려감.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // textfield 비활성화
        return true
    }
}
