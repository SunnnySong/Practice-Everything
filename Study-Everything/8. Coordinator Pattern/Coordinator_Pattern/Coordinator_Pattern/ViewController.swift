//
//  ViewController.swift
//  Coordinator_Pattern
//
//  Created by Sunny on 2023/06/26.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: ViewModel?
    
    @IBOutlet weak var presentModalButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        setupButton()
    }
    
    func setupButton() {
        presentModalButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    @objc func tappedButton() {
        
        viewModel?.text = textField.text ?? ""
        textField.text = ""
    }
    
}

