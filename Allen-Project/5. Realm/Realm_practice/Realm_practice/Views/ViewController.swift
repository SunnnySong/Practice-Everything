//
//  ViewController.swift
//  Realm_practice
//
//  Created by 송선진 on 2022/10/31.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Todo()
    
    // MARK: - Properties

    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupStatusBtn()
        setupUI()
    }

    // MARK: - Actions
    
    @IBAction func enterBtnTapped(_ sender: Any) {
        print("clicked")
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
        
        // textField에 글자 입력시, clear 버튼 자동 생성
        todoTextField.clearButtonMode = .whileEditing
        
    }

}


// UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    // cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Todo.rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TodoTableViewCell.self)", for: indexPath) as! TodoTableViewCell
        
        cell.cellStatusButton.clipsToBounds = true
        cell.cellStatusButton.layer.cornerRadius = 30 / 2
        
        let data = Todo.rowData[indexPath.row]
        cell.cellTextField.text = data.name
        cell.cellStatusButton.backgroundColor = data.status.statusColor
        
        let onGoing = UIAction(title: "진행중") { _ in
            cell.cellStatusButton.backgroundColor = .red
            data.status = .onGoing
        }
        let completion = UIAction(title: "완료") { _ in
            cell.cellStatusButton.backgroundColor = .yellow
            data.status = .completion
        }
        let buttonMenu = UIMenu(children: [onGoing, completion])
        cell.cellStatusButton.menu = buttonMenu
        
        // cell 선택시 회색 색깔 없애기
        cell.selectionStyle = .none
        
        return cell
    }
}

// UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    // 스토리보드에서 stackView나 cellStatusButton의 높이를 지정하려 하니 오류가 남. cell의 rowHeight를 바꿔줘야함
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}

