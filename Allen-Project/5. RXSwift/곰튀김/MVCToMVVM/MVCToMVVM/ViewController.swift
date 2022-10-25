//
//  ViewController.swift
//  MVCToMVVM
//
//  Created by 송선진 on 2022/10/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    // view 화면에 보여주기 위한 Model = viewModel
    // 즉, view를 관리하는 viewController는 viewModel과 소통
    let viewModel = ViewModel()
    
    @IBOutlet weak var datetimeLabel: UILabel!
    
    @IBAction func onYesterday() {
        viewModel.moveDay(day: -1)
    }
    
    @IBAction func onNow() {
        datetimeLabel.text = "Lodding..."
        viewModel.reload()
    }
    
    @IBAction func onTomorrow() {
        viewModel.moveDay(day: +1)
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewModel에서 var onUpdate: () -> Void = {} 클로저 형태로 정의. update 할 코드를 viewModel이 아닌 viewController에서 직접 구현할 수 있게 클로저 형태로 정의.
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                // app을 키면, 화면에 시간을 띄울 수 있도록 datetimeLabel의 text 변경
                // viewModel.dateTimeString에 didSet이 걸려있기 때문에 해당 값이 변하면 자동으로 datetimeLabel.text값이 업데이트됌.
                self?.datetimeLabel.text = self?.viewModel.dateTimeString
            }
        }
        // viewModel.dateTimeString은 didSet{ onUpdate() }가 걸려있어 해당 값이 변할때마다 onUpdate()가 실행됌. 즉 버튼을 눌러 시간을 변경할때마다 onUpdate()가 자동적으로 실행됌.
        // -> onUpdate()를 위에서 설정해줬기 때문에 이 이후에 onUpdate()가 실행될 때 위 코드 내용으로 작동됌.
        // -> 위 코드 이후 새로 onUpdate()를 작성한다면 그 코드로 onUpdate()가 실행될 것임. (ViewController 뿐만 아니라 어떤 파일에서든지 ViewModel.onUpdate를 실행하면 새로 정의한 코드로 작동됌.)
        
        // onUpdate() 정의 이후 reload()를 실행함으로써 화면에 띄울 시간 데이터를 가져오고 -> (viewModel에서 dateTimeString 값의 변화로 onUpdate()가 실행되기 때문에)자동으로 datetimeLabel.text 값이 변경됌.
        viewModel.reload()
    }
}

