//
//  ViewController.swift
//  TedioffMVVM
//
//  Created by Débora Oliveira on 01/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let mainView = View()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
        self.view = mainView
        
        self.title = "MVVM"
    }
}

extension ViewController: ViewDelegate {
    func didTapSearch() {
        Network.shared.requestJSON { (error, activity) in
            DispatchQueue.main.async {
                self.mainView.viewModel = MainViewModel(activity: activity!)
            }
        }
    }
}
