//
//  ViewController.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    
    let mainView = GetActivityView()
    
    var activity: Activity? {
        didSet {
            DispatchQueue.main.sync {
                self.mainView.setViewValues(with: activity)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
        self.view = mainView
        self.title = "MVC"
    }
}

// MARK: - ViewDelegate

extension ViewController: GetActivityViewDelegate {
    func didTapSearch() {
        mainView.startLoading()
        Network.shared.requestJSON(type: Activity.self, completion: {[weak self] (error, activity) in
            self?.activity = activity
            
            DispatchQueue.main.async {
                self?.mainView.stopLoading()
            }
        })
    }
}

