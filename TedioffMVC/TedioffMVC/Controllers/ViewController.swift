//
//  ViewController.swift
//  TedioffMVC
//
//  Created by Débora Oliveira on 30/08/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mainView = View()
    
    var activity: Activity? {
        didSet {
            DispatchQueue.main.sync {
                self.mainView.activityTitle = activity?.activity
                self.mainView.activityType = activity?.type.rawValue
                self.mainView.activityAccessibility = activity?.accessibility
                self.mainView.activityPrice = activity?.price
                self.mainView.activityParticipants = activity?.participants
                
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

extension ViewController: ViewDelegate {
    func didTapSearch() {
        Network.shared.requestJSON { (error, activity) in
            self.activity = activity
        }
    }
}

