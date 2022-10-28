//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    // MARK: - Life Cycle
    
    let cellId = "MenuItemTableViewCell"
    
    let viewModel = MenuListViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dataSource = .self 없이 menuObservable 통해 binding
        tableView.dataSource = nil
        
        // menuViewController에 메뉴 이름을 menuObservble 통해 binding 해주기
        viewModel.menuObservable
            // tableView의 row 하나를 item 이라 지칭
            .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: MenuItemTableViewCell.self)) { index, item, cell in
                // index: indexPath.row, item: tableView의 row 하나, cell: tableView의 cell
                
                // menuObservable이 바뀌면 tableView에 계속 전달
                cell.title.text = item.name
                cell.price.text = "\(item.price)"
                cell.count.text = "\(item.count)"
                
                // + / - 처리
                cell.onChange = { [weak self] increase in
                    self?.viewModel.changeCount(item: item, increase: increase)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.itemsCount
            .map { "\($0)" }
            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: {
//                self.itemCountLabel.text = $0
//            }) 대신 아래 sugar로 표현.
            // 들어온 데이터(String타입)를 그대로 label에 전달, reference count를 올리지 않고 label에 text를 전달해주기 때문에 순환참조 문제 X
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .map { $0.currencyKR() }
            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: {
//                self.totalPrice.text = $0
//            })
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
        viewModel.clearAllItemsSelections()
    }

    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
//        performSegue(withIdentifier: "OrderViewController", sender: nil)
  
        /*
         (구현하고 싶은 상황) Observable로 정의된 totalPrice 값을 받아 변경하고 싶지만, 앞에서 이미 .subscribe 를 했기 때문에 변경 불가
         (해결) Observable과 다르게 subject는 외부에서 데이터 컨트롤 가능. observer and Observable 모두 작동 가능. Observable처럼 값을 보내거나, 새로운 값으로 변경하는 것도 외부에서 가능.
         */
        viewModel.onOrder()
    }
}


// menuObservable을 binding해줌으로써 UITableViewDataSource 필요 없어짐.
//extension MenuViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.menuObservable.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell") as! MenuItemTableViewCell
//
//        let menu = viewModel.menus[indexPath.row]
//        cell.title.text = menu.name
//        cell.price.text = "\(menu.price)"
//        cell.count.text = "\(menu.count)"
//
//        return cell
//    }
//}
