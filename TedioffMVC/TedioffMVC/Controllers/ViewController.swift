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
    let activityManager = ActivityManager()
    
    var activity: Activity? {
        didSet {
            mainView.setViewValues(with: activity)
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
    func getNewActivity() {
        mainView.startLoading()
        activityManager.getActivity { [weak self] (activity) in
            DispatchQueue.main.async {
                self?.activity = activity
                self?.mainView.stopLoading()
            }
        }
    }
    
    func clearActivity() {
        self.activity = nil
    }
}

