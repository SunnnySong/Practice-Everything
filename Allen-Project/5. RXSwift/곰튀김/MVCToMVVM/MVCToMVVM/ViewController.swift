//
//  ViewController.swift
//  MVCToMVVM
//
//  Created by 송선진 on 2022/10/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
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
        
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.datetimeLabel.text = self?.viewModel.dateTimeString
            }
        }
        viewModel.reload()
    }
}

