//
//  BViewController.swift
//  Coordinator_Pattern
//
//  Created by Sunny on 2023/06/26.
//

import UIKit
import Combine

class BViewController: UIViewController {
    
    private var cancellables: Set<AnyCancellable> = []
    @IBOutlet weak var label: UILabel!
    
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
    }
    
    func bindingModel() {
        
        viewModel?.$text
            .sink { text in
                print(text)
                self.label.text = text
            }
            .store(in: &cancellables)
    }
}
