//
//  ViewController.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - ViewController

class ViewController: UIViewController {
    
    let mainView = GetActivityView()
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = mainView
        self.title = "Nubank Architecture"
    }
    
    // MARK: - Binding
    
    lazy var confirm: ControlEvent<Void> = {
        return self.mainView.newActivityButton.rx.tap
    }()
    
    lazy var clear: ControlEvent<Void> = {
        return self.mainView.clearButton.rx.tap
    }()
    
    func bind(_ viewModel: MainViewModel) {
        viewModel.configure(mainView)
    }
    
}
